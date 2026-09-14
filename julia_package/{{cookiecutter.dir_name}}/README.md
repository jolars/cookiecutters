# {{cookiecutter.project_name}} <a href="https://{{cookiecutter.github_user}}.github.io/{{cookiecutter.github_repo}}/"><img src='docs/src/assets/logo.svg' align="right" height="139" /></a>

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://{{cookiecutter.github_user}}.github.io/{{cookiecutter.github_repo}}/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://{{cookiecutter.github_user}}.github.io/{{cookiecutter.github_repo}}/dev)
[![Build
Status](https://github.com/{{cookiecutter.github_user}}/{{cookiecutter.github_repo}}/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/{{cookiecutter.github_user}}/{{cookiecutter.github_repo}}/actions/workflows/ci.yml?query=branch%3Amain)

{{cookiecutter.description}}

## Installation

You can install the package using the Julia package manager from the source code
on GitHub:

```julia
using Pkg
Pkg.add(url = "https://github.com/{{cookiecutter.github_user}}/{{cookiecutter.github_repo}}")
```

## Contributing

When writing commit messages, use the [Conventional Commits
format](https://www.conventionalcommits.org/en/v1.0.0/).

## Versioning

{{cookiecutter.project_name}} uses [semantic versioning](https://semver.org) and Versionary for
releases.

## Development

Enter the development environment and run the project tasks:

```console
devenv shell
devenv tasks run project:test
devenv tasks run project:docs
```

Run `devenv tasks list` to see all available tasks.
