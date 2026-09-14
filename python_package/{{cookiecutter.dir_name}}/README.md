# {{cookiecutter.project_name}}: {{cookiecutter.description}}

## Development

Enter the development environment and run the complete local check:

```console
devenv shell
devenv tasks run project:check
```

Build the documentation with `devenv tasks run project:docs`. To preview it and
rebuild it when sources change, run:

```console
devenv up docs
```
