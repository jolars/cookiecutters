"""My module for {{cookiecutter.project_name}} package."""

from __future__ import annotations

from _{{cookiecutter.project_slug}} import _my_function


class MyClass:
    """A sample class in my module."""

    def __init__(self, value: int):
        """Initialize MyClass with a value."""
        self.value: int = value

    def get_value(self):
        """Return the stored value."""
        return self.value

def my_function(a: int, b: int) -> int:
    """Return the sum of two integers."""
    return _my_function(a, b)
