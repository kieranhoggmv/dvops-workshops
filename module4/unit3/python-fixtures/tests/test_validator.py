import pytest
from validator import validate_user_id


# -----------------
# Task 1 Test: Positive ID (Rule 1)
# -----------------
def test_valid_positive_id():
    """Rule 1: Returns True for a valid, positive integer ID (the 'happy path')."""
    # Checks the expected output for a valid case
    assert validate_user_id(101) is True


# -----------------
# Task 3 Test: Negative ID (Rule 2)
# -----------------
def test_negative_id_returns_false():
    """Rule 2: Returns False if the ID is a negative number."""
    assert validate_user_id(-5) is False

# Implicit test for zero, derived from Rule 1 (not positive).
# While not explicitly required, this test is necessary to ensure the solution's logic is robust.
def test_zero_id_returns_false():
    """Implicit Test: Returns False if the ID is zero."""
    assert validate_user_id(0) is False


# -----------------
# Simple Task 4 Test: Non-Integer Type (Rule 3) 
# -----------------
def test_non_integer_input_raises_type_error():
    """Rule 3: Raises a specific TypeError if the ID is passed as a string or float."""
    
    # Test for string input
    with pytest.raises(TypeError) as e:
        validate_user_id("abc")
    assert "User ID must be an integer." in str(e.value)
    
    # Test for float input
    with pytest.raises(TypeError) as e:
        validate_user_id(10.5)
    assert "User ID must be an integer." in str(e.value)

# -----------------
# Advanced Task 4 Test: Non-Integer Type (Rule 3) 
# -----------------
@pytest.mark.parametrize("invalid_input", ["3", 3.5, True, None])
def test_non_integer_raises_type_error(invalid_input):
    """Rule 3: Raises a specific TypeError if the ID is passed as a string or float."""
  
    # As above, but making use of pytest.raises' match parameter, as well as parameterised tests
    with pytest.raises(TypeError, match="User ID must be an integer."):
        validate_user_id(invalid_input)
