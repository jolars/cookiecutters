# AGENTS.md

## Project overview

{{cookiecutter.project_name}} is a Rust 2024 library crate. Its public API lives under `src/`, and
integration tests belong in `tests/`.

## Validation

Run focused tests while developing, then run the complete check before handing
off a nontrivial change:

```bash
task check
```

The individual checks are:

```bash
cargo fmt --all -- --check
cargo clippy --all-targets --all-features -- -D warnings
cargo test --all-features
RUSTDOCFLAGS="-D warnings" cargo doc --no-deps --all-features
panache format --check .
panache lint .
```

## Repository conventions

- Preserve the declared Rust 1.89 minimum supported version unless a change
  explicitly requires raising it.
- Add a regression test before fixing observable behavior.
- Use Conventional Commits; Versionary derives releases from the commit history.
- Do not edit `CHANGELOG.md` manually. Versionary owns it.
