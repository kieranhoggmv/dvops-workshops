import pytest
from db_mock import mock_payment_database_query
from validator import validate_user_id


def test_successful_payment_status_integration():
    """
    Verifies that the system correctly interprets a successful status 
    from the mocked external payment database.
    """
    # 1. Define the user and the mock's expected input
    user_id = 9001

    # 2. Call the mock function (simulating the external call)
    db_response = mock_payment_database_query(user_id, 200)

    # 3. Ensure the returned user ID is valid
    assert validate_user_id(db_response["user_id"]) is True

    # 4. Assert the contract: The response must contain the expected success status
    assert db_response["user_id"] == user_id
    assert db_response["payment_status"] == "PAID"


def test_failed_payment_status_integration():
    """
    Verifies that the system correctly handles a non-200 status 
    from the mocked external payment database.
    """
    # 1. Define the user and the mock's expected input
    user_id = 9002
    
    # 2. Call the mock function (simulating the external call)
    db_response = mock_payment_database_query(user_id, 500)

    # 3. Ensure the returned user ID is valid
    assert validate_user_id(db_response["user_id"]) is True

    # 4. Assert the contract: The response must contain the expected failure status
    assert db_response["user_id"] == user_id
    assert db_response["payment_status"] == "PENDING"
