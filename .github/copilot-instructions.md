# Copilot Instructions for Cookiecutters Repository

## Repository Overview

This repository contains a collection of [cookiecutter](https://cookiecutter.readthedocs.io/en/latest/) templates for scaffolding various types of projects. The repository includes 7 different templates for quickly creating Python packages, Julia packages, Python/C++ packages, R projects, and LaTeX documents (articles, posters, and presentations).

**Repository Type**: Template collection
**Primary Language**: Jinja2 templates (Python-based templating engine)
**Size**: Small (~50 files across all templates)
**License**: MIT

## Repository Structure

```
/
├── .github/
│   ├── workflows/           # CI workflows for testing each template
│   │   ├── test-python-package.yml
│   │   ├── test-julia-package.yml
│   │   ├── test-python-cpp-package.yml
│   │   ├── test-r-project.yml
│   │   ├── test-tex-article.yml
│   │   ├── test-tex-poster.yml
│   │   └── test-tex-presentation.yml
│   └── dependabot.yml      # Dependabot configuration
├── python_package/          # Python package template
│   ├── cookiecutter.json
│   └── {{cookiecutter.slug}}/
├── julia_package/           # Julia package template
│   ├── cookiecutter.json
│   ├── README.md
│   └── {{cookiecutter.slug}}/
├── python_cpp_package/      # Python/C++ package template
│   ├── cookiecutter.json
│   └── {{cookiecutter.dir_name}}/
├── r_project/               # R project template
│   ├── cookiecutter.json
│   └── {{cookiecutter.project_name}}/
├── tex_article/             # LaTeX article template
│   ├── cookiecutter.json
│   └── {{cookiecutter.slug}}/
├── tex_poster/              # LaTeX poster template
│   ├── cookiecutter.json
│   └── {{cookiecutter.slug}}/
├── tex_presentation/        # LaTeX presentation template
│   ├── cookiecutter.json
│   └── {{cookiecutter.dirname}}/
├── .gitignore               # Contains "indent.log"
├── LICENSE                  # MIT License
└── README.md                # Main repository README
```

## Build and Test Instructions

### Prerequisites

**ALWAYS install the following before testing any templates:**

```bash
pip install cookiecutter
```

**For `python_cpp_package` template only, also install:**

```bash
pip install jinja2-time
```

### Testing Templates

Each template can be tested using the cookiecutter command. **IMPORTANT**: Always generate templates in `/tmp` to avoid polluting the repository.

#### General Pattern for All Templates

```bash
cd /tmp
cookiecutter --no-input /path/to/cookiecutters/<template_name>
```

#### Template-Specific Commands

**1. python_package** (generates directory: `pkg`)
```bash
cd /tmp
cookiecutter --no-input /home/runner/work/cookiecutters/cookiecutters/python_package
# Verify: test -d pkg
```

**2. julia_package** (generates directory: `Pkg`)
```bash
cd /tmp
cookiecutter --no-input /home/runner/work/cookiecutters/cookiecutters/julia_package
# Verify: test -d Pkg
```

**3. python_cpp_package** (generates directory: `mypkg`)
```bash
cd /tmp
cookiecutter --no-input /home/runner/work/cookiecutters/cookiecutters/python_cpp_package
# Verify: test -d mypkg
```

**4. r_project** (generates directory: `ReproducibleRProject`)
```bash
cd /tmp
cookiecutter --no-input /home/runner/work/cookiecutters/cookiecutters/r_project
# Verify: find . -maxdepth 1 -type d ! -name "." ! -name ".." | grep -q .
```

**5. tex_article** (generates directory: `an_article`)
```bash
cd /tmp
cookiecutter --no-input /home/runner/work/cookiecutters/cookiecutters/tex_article
# Verify: find . -maxdepth 1 -type d ! -name "." ! -name ".." | grep -q .
```

**6. tex_poster** (generates directory: `a_poster`)
```bash
cd /tmp
cookiecutter --no-input /home/runner/work/cookiecutters/cookiecutters/tex_poster
# Verify: find . -maxdepth 1 -type d ! -name "." ! -name ".." | grep -q .
```

**7. tex_presentation** (generates directory: `date-a-presentation`)
```bash
cd /tmp
cookiecutter --no-input /home/runner/work/cookiecutters/cookiecutters/tex_presentation
# Verify: find . -maxdepth 1 -type d ! -name "." ! -name ".." | grep -q .
```

## GitHub Workflows and CI

### Continuous Integration

Each template has its own dedicated workflow in `.github/workflows/` that:
1. Checks out the repository
2. Sets up Python (version 3.x or 3.11 for python_cpp_package)
3. Installs cookiecutter (and jinja2-time for python_cpp_package)
4. Generates the template in `/tmp` using `--no-input`
5. Verifies the generated directory exists

**Workflow Triggers:**
- Push to main/master branches
- Pull requests to main/master branches
- Path-specific: only when files in the template directory or workflow file change
- Weekly schedule (Sundays at midnight UTC)
- Manual dispatch (workflow_dispatch)

**Special Case - python_cpp_package Workflow**:
This workflow goes beyond basic generation and also:
- Installs uv, pip, pybind11, setuptools
- Installs the generated package with `uv pip install --system -e .`
- Installs dev dependencies with `uv pip install --system -e . --group dev`
- Runs tests with `pytest tests/ -v`
- Builds documentation with `make html` in the docs directory

### Dependabot

The repository uses Dependabot to keep GitHub Actions up to date:
- Package ecosystem: github-actions
- Update schedule: weekly

## Template Details

### cookiecutter.json Configuration

Each template has a `cookiecutter.json` file that defines default values and template variables:

- **python_package**: slug="pkg", uses `_copy_without_render` for binaries and workflow files
- **julia_package**: slug="Pkg", includes README.md, uses `_copy_without_render` for PDFs
- **python_cpp_package**: dir_name="mypkg", uses jinja2-time extension, multiple license options
- **r_project**: project_name="ReproducibleRProject", includes R package structure
- **tex_article**: slug="an_article", single_author option
- **tex_poster**: slug="a_poster", configurable size (default: a0)
- **tex_presentation**: dirname="date-a-presentation", single_author option

### Template Variable Naming

**IMPORTANT**: Each template uses different variable names for the main directory:
- `python_package`: `{{cookiecutter.slug}}`
- `julia_package`: `{{cookiecutter.slug}}`
- `python_cpp_package`: `{{cookiecutter.dir_name}}`
- `r_project`: `{{cookiecutter.project_name}}`
- `tex_article`: `{{cookiecutter.slug}}`
- `tex_poster`: `{{cookiecutter.slug}}`
- `tex_presentation`: `{{cookiecutter.dirname}}`

## Making Changes to Templates

### File Paths

When editing template files, use the full path with the cookiecutter variable in the directory name. For example:
- Python package: `/home/runner/work/cookiecutters/cookiecutters/python_package/{{cookiecutter.slug}}/pyproject.toml`
- Julia package: `/home/runner/work/cookiecutters/cookiecutters/julia_package/{{cookiecutter.slug}}/Project.toml`

### Testing Changes

**ALWAYS test your changes by:**
1. Generating the template with cookiecutter in `/tmp`
2. Verifying the generated output matches expectations
3. For `python_cpp_package`, also verify it can be built and tested

### Files to Ignore

The `.gitignore` contains `indent.log` which should not be committed.

## Key Facts

1. **No Build Process**: This repository doesn't require building - it's a collection of templates
2. **No Direct Tests**: Tests are performed by generating templates via cookiecutter
3. **Path-Based CI**: Workflows only run when their specific template directory changes
4. **Python Runtime**: Python 3.x is used across all workflows (3.11 for python_cpp_package)
5. **jinja2-time Extension**: Only `python_cpp_package` requires the jinja2-time extension
6. **`_copy_without_render`**: All templates use this to exclude binary files (PDFs, images) from Jinja2 rendering
7. **GitHub Workflows in Templates**: Templates contain their own `.github/workflows/` directories that get rendered with cookiecutter variables

## Template Content Structure

### python_package
- Uses hatchling build system
- Includes Sphinx documentation with furo theme
- Has CI/CD with release-please integration
- Includes pytest, ruff linting configuration
- Python 3.8+ compatible

### python_cpp_package  
- Uses scikit-build-core with pybind11
- CMake-based C++ build system
- Includes comprehensive docs with Sphinx
- Python 3.9+ compatible
- Supports multiple licenses (MIT, GPL, BSD-3, Apache 2.0)

### julia_package
- Includes Documenter.jl for documentation
- Has Project.toml and test structure
- Includes Makefile for common tasks
- Uses release-please for versioning

### r_project
- Complex structure with paper/, results/, scripts/, data/ directories
- Includes nested R package structure
- Has Makefile for automation
- Supports Rcpp for C++ integration

### TeX templates (article/poster/presentation)
- Include `.latexindent.yaml` for formatting
- Have `.texlabroot` marker files
- Use custom macros and preambles
- Include bibliography files

## Best Practices

1. **Always test in /tmp**: Never generate templates in the repository directory
2. **Test after changes**: Always run cookiecutter after modifying a template
3. **Check workflows**: When changing templates, ensure the corresponding workflow still passes
4. **Respect `_copy_without_render`**: Don't modify binary files that are marked for copying without rendering
5. **Use `--no-input`**: When testing, use `--no-input` flag to use default values
6. **Path-specific PRs**: Changes to one template won't trigger CI for other templates

## Trust These Instructions

These instructions have been validated by testing all commands in a clean environment. When working with this repository, trust these instructions and only search for additional information if you encounter errors or if these instructions appear incomplete or incorrect for your specific task.
