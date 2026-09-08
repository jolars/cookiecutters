"""Main module for {{cookiecutter.project_name}}."""

from __future__ import annotations

from importlib.metadata import version

from .my_module import MyClass, my_function

__all__ = ["MyClass", "__version__", "my_function"]

__version__ = version("{{cookiecutter.project_slug}}")
