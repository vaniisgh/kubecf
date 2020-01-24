def _publish_impl(ctx):
    script = ctx.actions.declare_file("publish.rb")
    binaries_separator = "||"
    ctx.actions.expand_template(
        template = ctx.file._script_tmpl,
        output = script,
        substitutions = {
            "{binaries_separator}": binaries_separator,
            "{binaries}": binaries_separator.join([f.short_path for f in ctx.files.data]),
        },
        is_executable = True,
    )
    runfiles = ctx.files.data
    return [DefaultInfo(
        executable = script,
        runfiles = ctx.runfiles(files = runfiles),
    )]

publish = rule(
    implementation = _publish_impl,
    attrs = {
        "data": attr.label_list(
            allow_files = True,
            mandatory = True,
        ),
        "_script_tmpl": attr.label(
            allow_single_file = True,
            default = "//rules/publish:publish.tmpl.rb",
        ),
    },
    executable = True,
)
