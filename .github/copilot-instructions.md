# Copilot Instructions

This repository contains independent Cookiecutter templates. Read `CLAUDE.md`
for the complete repository guidance before editing a template.

## Template inventory

The maintained package templates are:

- `rust_package`
- `julia_package`
- `python_package`
- `python_cpp_package`
- `r_package`

They share a baseline built around devenv, GitHub Actions, grouped Dependabot
updates, Panache, Versionary, and `AGENTS.md`. The repository also contains an R
research-project template and three TeX templates; do not assume the package
release baseline belongs in those project types.

Each template has its own `cookiecutter.json` and generated-directory
expression. Inspect those files rather than assuming variable names. Preserve
`_copy_without_render` entries for GitHub workflow expressions, Go Task
expressions, and binary assets that Jinja must not interpret.

## Editing and validation

Keep template values consistent across manifests, README files, CI, devenv,
Versionary, Dependabot, Panache, and `AGENTS.md`. Do not reintroduce
release-please or semantic-release into package templates.

Render every changed template into a fresh directory under `/tmp` with
`cookiecutter --no-input`. Check the rendered tree for unresolved Jinja and
placeholder content, then run the generated project's formatter, linter, tests,
build, and documentation checks. A successful render alone is not sufficient.

Use the corresponding path-filtered workflow under `.github/workflows/` as the
minimum CI contract. For package-template changes, also check generated workflow
syntax with `actionlint`, TOML with Taplo, and Markdown with the rendered
Panache configuration.
