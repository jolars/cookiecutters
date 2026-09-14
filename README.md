# Cookiecutters :cookie:

This repository contains a collection of
[cookiecutter](https://cookiecutter.readthedocs.io/en/latest/) templates for
quickly scaffolding various types of projects. Each template is designed to help
you get started with best practices and standard structures for different kinds
of applications and libraries.

Package templates are available for Rust, Python, Python/C++, Julia, and R. They
share a repository baseline built around devenv, GitHub Actions, Dependabot,
Panache, Versionary, and `AGENTS.md`. Separate templates cover reproducible R
projects and LaTeX documents.

Package templates and the R research-project template define development
commands as [devenv tasks](https://devenv.sh/tasks/) in `devenv.nix`. Run
`devenv tasks list` to see the available commands, then run a task with
`devenv tasks run project:test`, for example. Python templates also provide a
documentation preview [process](https://devenv.sh/processes/), started with
`devenv up docs`.
