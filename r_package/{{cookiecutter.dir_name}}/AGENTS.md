# AGENTS.md

## Project overview

{{cookiecutter.package_name}} is an R package. Package code lives in `R/`, tests live in
`tests/testthat/`, generated documentation lives in `man/`, and pkgdown
configuration lives in `_pkgdown.yml`.

## Validation

Run focused tests while developing, then run the complete verification before
handing off a nontrivial change:

```bash
task verify
```

The individual checks are:

```bash
Rscript -e 'devtools::test()'
Rscript -e 'devtools::check()'
air format --check .
panache format --check .
panache lint .
```

## Repository conventions

- Generate `NAMESPACE` and `man/` files from roxygen comments; do not hand-edit
  them.
- Generate `README.md` from `README.qmd`; edit the Quarto source instead.
- Add a focused testthat regression test before fixing observable behavior.
- Use Conventional Commits; Versionary derives releases from the commit history.
- Do not edit `NEWS.md` manually. Versionary owns it.
