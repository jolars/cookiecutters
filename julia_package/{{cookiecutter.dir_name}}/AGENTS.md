# AGENTS.md

## Project overview

{{cookiecutter.project_name}} is a Julia package. Package code lives in `src/`, tests live in `test/`, and
Documenter sources live in `docs/`.

## Validation

Run the package tests and documentation build before handing off a nontrivial
change:

```bash
task test
task docs
panache format --check .
panache lint .
```

## Repository conventions

- Keep `[compat]` bounds in `Project.toml` aligned with supported Julia and
  dependency versions.
- Add a focused regression test for observable behavior changes.
- Use Conventional Commits; Versionary derives releases from the commit history.
- Do not edit `CHANGELOG.md` manually. Versionary owns it.
- Do not hand-edit generated Documenter output under `docs/build/`.
