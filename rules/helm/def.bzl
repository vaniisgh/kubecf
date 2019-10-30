load("@bazel_skylib//lib:paths.bzl", "paths")

def _package_impl(ctx):
    template_name = paths.basename(ctx.file._script_template.short_path)
    script = ctx.actions.declare_file("rendered_{}".format(template_name))
    output_filename = "{}-{}.tgz".format(ctx.attr.chart_name, ctx.attr.chart_version)
    output_tgz = ctx.actions.declare_file(output_filename)
    outputs = [output_tgz]
    ctx.actions.expand_template(
        template = ctx.file._script_template,
        output = script,
        substitutions = {
            "{PACKAGE_DIR}": ctx.attr.package_dir,
            # TODO(f0rmiga): Figure out a way of working with paths that contain spaces.
            "{TARS}": " ".join([f.path for f in ctx.files.tars]),
            "{HELM}": ctx.executable._helm.path,
            "{CHART_VERSION}": ctx.attr.chart_version,
            "{APP_VERSION}": ctx.attr.app_version,
            "{OUTPUT_FILENAME}": output_filename,
            "{OUTPUT_TGZ}": output_tgz.path,
        },
        is_executable = True,
    )
    ctx.actions.run(
        inputs = [] + ctx.files.srcs + ctx.files.tars,
        outputs = outputs,
        tools = [ctx.executable._helm],
        progress_message = "Generating Helm package archive {}".format(output_filename),
        executable = script,
    )
    return [DefaultInfo(files = depset(outputs))]

_package = rule(
    implementation = _package_impl,
    attrs = {
        "srcs": attr.label_list(
            mandatory = True,
        ),
        "tars": attr.label_list(),
        "package_dir": attr.string(
            mandatory = True,
        ),
        "chart_name": attr.string(
            mandatory = True,
        ),
        "chart_version": attr.string(
            mandatory = True,
        ),
        "app_version": attr.string(
            mandatory = True,
        ),
        "_helm": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "@helm//:helm",
            executable = True,
        ),
        "_script_template": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "//rules/helm:package.sh",
        ),
    },
)

def package(**kwargs):
    _package(
        package_dir = native.package_name(),
        **kwargs
    )

PackageInfo = provider(
    fields=[
        "chart_name",
        "chart_version",
    ],
)

def _template_impl(ctx):
    template_name = paths.basename(ctx.file._script_template.short_path)
    script = ctx.actions.declare_file("rendered_{}".format(template_name))
    output_filename = "{}.yaml".format(ctx.attr.name)
    output_yaml = ctx.actions.declare_file(output_filename)
    outputs = [output_yaml]
    ctx.actions.expand_template(
        template = ctx.file._script_template,
        output = script,
        substitutions = {
            "{WORKSPACE_STATUS_ENVIRONMENT}": ctx.file._workspace_status_environment.path,
            "{HELM}": ctx.executable._helm.path,
            "{INSTALL_NAME}": ctx.attr.install_name,
            "{CHART_PACKAGE}": ctx.file.chart_package.path,
            "{OUTPUT_YAML}": output_yaml.path,
        },
        is_executable = True,
    )
    arguments = ctx.actions.args()
    for (key, value) in ctx.attr.set_values.items():
        arguments.add("--set", "{}={}".format(key, value))
    for f in ctx.files.values:
        arguments.add("--values", f.path)
    ctx.actions.run(
        inputs = [ctx.file.chart_package, ctx.file._workspace_status_environment] + ctx.files.values,
        outputs = outputs,
        tools = [ctx.executable._helm],
        progress_message = "Rendering Helm package to {}".format(output_filename),
        executable = script,
        arguments = [arguments],
    )
    return [DefaultInfo(files = depset(outputs))]

template = rule(
    implementation = _template_impl,
    attrs = {
        "set_values": attr.string_dict(
            default = {},
        ),
        "values": attr.label_list(
            default = [],
            allow_files = True,
        ),
        "install_name": attr.string(
            mandatory = True,
        ),
        "chart_package": attr.label(
            mandatory = True,
            allow_single_file = True,
        ),
        "_workspace_status_environment": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "//rules/workspace_status_environment",
        ),
        "_helm": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "@helm//:helm",
            executable = True,
        ),
        "_script_template": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "//rules/helm:template.sh",
        ),
    },
)
