# AGENTS.md

## Project overview

{{cookiecutter.project_name}} is a Python package with a C++ extension built by scikit-build-core and
pybind11. Python code lives in `{{cookiecutter.project_slug}}/`, C++ bindings live in `src/`, tests live
in `tests/`, and Sphinx sources live in `docs/`.

## Validation

Run focused tests while developing, then run the complete check before handing
off a nontrivial change:

```bash
devenv tasks run project:check
```

The individual checks are:

```bash
ruff format --check .
ruff check .
clang-format --dry-run --Werror src/*.cpp
pytest
sphinx-build -M doctest docs/source docs/build
panache format --check .
panache lint .
```

## Repository conventions

- Keep the Python and C++ interfaces synchronized when changing bindings.
- Preserve the C++ standard and Python support range declared by the build
  configuration.
- Add a focused regression test before fixing observable behavior.
- Use Conventional Commits; Versionary derives releases from the commit history.
- Do not edit `CHANGELOG.md` manually. Versionary owns it.
- Do not hand-edit generated Sphinx output under `docs/build/`.
