import pytest
from validator import validate_user_id

# Note: needs pytest-mock to be installed

def test_successful_payment_status_integration(mocker):
    """
    Verifies that the system correctly interprets a successful status 
    using the pytest-mock mocker fixture.
    """
    # 1. Patch the real database function using the mocker fixture
    mock_query = mocker.patch('payments.payment_database_query')
    
    # 2. Define the user and configure the mock's expected return value
    user_id = 9001
    mock_query.return_value = {
        "user_id": user_id, 
        "payment_status": "PAID", 
        "query_time_ms": 10
    }

    # 3. Call the mocked function (simulating the external call)
    db_response = mock_query(user_id, 200)

    # 4. Ensure the returned user ID is valid
    assert validate_user_id(db_response["user_id"]) is True

    # 5. Assert the contract: The response must contain the expected success status
    assert db_response["user_id"] == user_id
    assert db_response["payment_status"] == "PAID"
    
    # 6. Verify the mock was called with the correct parameters
    mock_query.assert_called_once_with(user_id, 200)


def test_failed_payment_status_integration(mocker):
    """
    Verifies that the system correctly handles a non-200 status 
    using the pytest-mock mocker fixture.
    """
    # 1. Patch the real database function using the mocker fixture
    mock_query = mocker.patch('payments.payment_database_query')
    
    # 2. Define the user and configure the mock's expected return value
    user_id = 9002
    mock_query.return_value = {
        "user_id": user_id, 
        "payment_status": "PENDING", 
        "query_time_ms": 10
    }
    
    # 3. Call the mocked function (simulating the external call)
    db_response = mock_query(user_id, 500)

    # 4. Ensure the returned user ID is valid
    assert validate_user_id(db_response["user_id"]) is True

    # 5. Assert the contract: The response must contain the expected failure status
    assert db_response["user_id"] == user_id
    assert db_response["payment_status"] == "PENDING"
    
    # 6. Verify the mock was called with the correct parameters
    mock_query.assert_called_once_with(user_id, 500)