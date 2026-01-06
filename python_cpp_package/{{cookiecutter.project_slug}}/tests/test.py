"""Basic test for the {{ cookiecutter.project_name }} package."""

from {{ cookiecutter.project_slug }} import MyClass, add

def test_my_class():
    """Test the MyClass functionality."""
    obj = MyClass(10)
    assert obj.get_value() == 10

def test_add_function():
    """Test the add function."""
    from {{ cookiecutter.project_slug }} import add
    assert add(3, 5) == 8
    assert add(-1, 1) == 0
