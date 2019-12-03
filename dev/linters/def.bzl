def _helmlint_impl(ctx):
    script = ctx.actions.declare_file(ctx.attr.name)
    ctx.actions.expand_template(
        template = ctx.file._script_template,
        output = script,
        substitutions = {
            "{chart}": ctx.file.chart.short_path,
            "{helm}": ctx.executable._helm.short_path,
        },
        is_executable = True,
    )
    return [DefaultInfo(
        executable = script,
        runfiles = ctx.runfiles(files = [
            ctx.file.chart,
            ctx.executable._helm,
        ]),
    )]

helmlint = rule(
    implementation = _helmlint_impl,
    attrs = {
        "chart": attr.label(
            allow_single_file = True,
        ),
        "_script_template": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "//dev/linters:helmlint.sh",
        ),
        "_helm": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "@helm//helm",
            executable = True,
        ),
    },
    executable = True,
)

def _shellcheck_impl(ctx):
    script = ctx.actions.declare_file(ctx.attr.name)
    ctx.actions.expand_template(
        template = ctx.file._script_template,
        output = script,
        substitutions = {
            "{root_file}": ctx.file._root_file.short_path,
            "{shellcheck}": ctx.executable._shellcheck.short_path,
        },
        is_executable = True,
    )
    return [DefaultInfo(
        executable = script,
        runfiles = ctx.runfiles(files = [
            ctx.file._root_file,
            ctx.executable._shellcheck,
        ]),
    )]

shellcheck = rule(
    implementation = _shellcheck_impl,
    attrs = {
        "_script_template": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "//dev/linters:shellcheck.sh",
        ),
        "_root_file": attr.label(
            allow_single_file = True,
            default = "//:BUILD.bazel",
        ),
        "_shellcheck": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "@shellcheck//shellcheck",
            executable = True,
        ),
    },
    executable = True,
)

def _yamllint_impl(ctx):
    script = ctx.actions.declare_file(ctx.attr.name)
    ctx.actions.expand_template(
        template = ctx.file._script_template,
        output = script,
        substitutions = {
            "{root_file}": ctx.file._root_file.short_path,
            "{yamllint.par}": ctx.executable.binary.short_path,
        },
        is_executable = True,
    )
    return [DefaultInfo(
        executable = script,
        runfiles = ctx.runfiles(files = [
            ctx.file._root_file,
            ctx.executable.binary,
        ]),
    )]

yamllint = rule(
    implementation = _yamllint_impl,
    attrs = {
        "binary": attr.label(
            allow_single_file = True,
            cfg = "host",
            executable = True,
            mandatory = True,
        ),
        "_script_template": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "//dev/linters:yamllint.sh",
        ),
        "_root_file": attr.label(
            allow_single_file = True,
            default = "//:BUILD.bazel",
        ),
    },
    executable = True,
)
