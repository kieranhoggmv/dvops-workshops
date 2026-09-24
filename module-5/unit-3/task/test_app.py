import pytest
from app import greet, add

def test_greet():
    assert greet("DOE") == "Hello, DevOps!"
    assert greet("DevOps") == "Hello, DevOps!"

def test_add():
    assert add(5, 5) == 10
    assert add(1, 1) != 2
