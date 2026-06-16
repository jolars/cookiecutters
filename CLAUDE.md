# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A collection of [cookiecutter](https://cookiecutter.readthedocs.io/) templates for
scaffolding the author's own project types: Python, Julia, and Python/C++ packages;
R packages and reproducible R projects; and LaTeX articles, posters, and
presentations. There is no application code and no build step—the "source" is the
templates themselves.

Each top-level directory is one independent template:
`python_package/`, `python_cpp_package/`, `julia_package/`, `r_package/`,
`r_project/`, `tex_article/`, `tex-poster/`, `tex_presentation/`. Each contains a
`cookiecutter.json` and a single rendered directory.

## Editing templates

- Template files live under the rendered directory whose name is a Jinja2
  expression, e.g. `python_package/{{cookiecutter.dir_name}}/pyproject.toml`.
  Quote these paths in the shell (the `{{ }}` braces are glob/brace-expansion bait).
- **The rendered directory is `{{cookiecutter.dir_name}}` for every template
  except `tex-poster`, which uses `{{cookiecutter.slug}}`.** Don't assume the
  variable name; check the template you're editing.
- File and directory names, not just file contents, are rendered—e.g.
  `{{cookiecutter.project_slug}}.tex`.
- Untracked leftover directories like `{{cookiecutter.slug}}/` or
  `{{cookiecutter.project_name}}/` exist inside some templates from past renames.
  They are git-ignored cruft; the live template is whatever `git ls-files` tracks
  (always the `dir_name`/`slug` dir above). Edit only the tracked directory.
- `_copy_without_render` in each `cookiecutter.json` lists globs (PDFs, images,
  compiled objects, and often `.github/*` or `.github/workflows/*`) that are copied
  verbatim. Files matching these are NOT Jinja2-rendered, so cookiecutter variables
  inside them stay literal—keep that in mind when adding such files.
- `python_cpp_package` is the only template using the `jinja2_time` extension
  (for `{% now %}`), so its `year` is computed; other templates hardcode the year
  string and need periodic bumping.

## Testing a template

Templates are validated by generating them; there are no unit tests. Always
generate into a throwaway dir, never the repo:

```fish
cd /tmp
cookiecutter --no-input /home/jola/.cookiecutters/<template_name>
```

`--no-input` uses the defaults from `cookiecutter.json`. For `python_cpp_package`
you also need `pip install jinja2-time` (or run it from an environment that has it).
After a change, regenerate and inspect the output dir to confirm Jinja2 renders
cleanly and filenames came out as expected.

The `python_cpp_package` CI goes further than generation: it installs the generated
package with `uv pip install -e .`, runs `pytest tests/ -v`, and builds docs with
`make html`. If you change that template, run those steps against the generated
project.

## CI

Each template has its own workflow in `.github/workflows/test-<template>.yml`,
path-filtered to that template's directory (plus a weekly schedule and manual
dispatch). A change to one template only triggers its own workflow—so verify the
generation locally for the template you touched rather than relying on CI to cover
siblings.

## Conventions baked into the generated projects

These reflect the author's tooling and are worth preserving across templates for
consistency:

- Tasks via `Taskfile.yml` (newer templates, e.g. `r_package`,
  `python_cpp_package`) or `Makefile` (older, e.g. `r_project`).
- `devenv` (`devenv.nix`/`.envrc`) for environment setup in some templates.
- `uv` for Python dependency/install management.
- Formatting config shipped per language: `air.toml` (R), `.latexindent.yaml`
  and `.texlabroot` (LaTeX), `ruff` (Python).
- Documentation via Sphinx (Python) or Documenter.jl (Julia); `release-please`
  for versioning in package templates.
