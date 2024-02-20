# {{cookiecutter.slug}} <a href="https://{{cookiecutter.github_user}}.github.io/{{cookiecutter.slug}}.jl/"><img src='docs/src/assets/logo.svg' align="right" height="139" /></a>

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://{{cookiecutter.github_user}}.github.io/{{cookiecutter.slug}}.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://{{cookiecutter.github_user}}.github.io/{{cookiecutter.slug}}.jl/dev)
[![Build Status](https://github.com/{{cookiecutter.github_user}}/{{cookiecutter.slug}}.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/{{cookiecutter.github_user}}/{{cookiecutter.slug}}.jl/actions/workflows/CI.yml?query=branch%3Amain)

{{cookiecutter.description}}

## Installation

You can install the package using the Julia package manager from the source code on GitHub:

```julia
using Pkg
Pkg.add(url = "https://github.com/{{cookiecutter.github_user}}/{{cookiecutter.slug}}.jl")
```

## Contributing

When writing commit messages, please use the [conventional commits format](https://www.conventionalcommits.org/en/v1.0.0/).

## Versioning

{{cookiecutter.slug}} uses [semantic versioning](https://semver.org).
