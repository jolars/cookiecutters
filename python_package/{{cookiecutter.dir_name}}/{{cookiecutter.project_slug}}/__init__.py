from importlib.metadata import version

from .foo import bar

__all__ = ["__version__", "bar"]

__version__ = version("{{cookiecutter.project_slug}}")
