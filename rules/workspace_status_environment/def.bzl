def _workspace_status_environment_impl(ctx):
    environment = ctx.actions.declare_file("workspace_status_environment.sh")
    convert_script = ctx.actions.declare_file("convert.sh")
    outputs = [environment]
    ctx.actions.expand_template(
        template = ctx.file._convert_script_template,
        output = convert_script,
        substitutions = {
            "{INFO_FILE}": ctx.info_file.path,
            "{VERSION_FILE}": ctx.version_file.path,
            "{OUTPUT}": environment.path,
        },
        is_executable = True,
    )
    ctx.actions.run(
        inputs = [
            ctx.info_file,
            ctx.version_file,
        ],
        outputs = outputs,
        progress_message = "Creating environment file from Bazel workspace status",
        executable = convert_script,
    )
    return [DefaultInfo(files = depset(outputs))]

workspace_status_environment = rule(
    implementation = _workspace_status_environment_impl,
    attrs = {
        "_convert_script_template": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "//rules/workspace_status_environment:convert.sh",
        ),
    },
)
