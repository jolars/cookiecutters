# AGENTS.md

## Project overview

{{cookiecutter.project_name}} is a Python 3.10+ package. Package code lives in `{{cookiecutter.project_slug}}/`, tests live in
`tests/`, and Sphinx sources live in `docs/`.

## Validation

Run focused tests while developing, then run the complete check before handing
off a nontrivial change:

```bash
task check
```

The individual checks are:

```bash
ruff format --check .
ruff check .
pytest
make -C docs html
panache format --check .
panache lint .
```

## Repository conventions

- Support every Python version declared in `pyproject.toml` and CI.
- Add a focused regression test before fixing observable behavior.
- Use NumPy-style docstrings for public APIs.
- Use Conventional Commits; Versionary derives releases from the commit history.
- Do not edit `CHANGELOG.md` manually. Versionary owns it.
- Do not hand-edit generated Sphinx output under `docs/build/`.
