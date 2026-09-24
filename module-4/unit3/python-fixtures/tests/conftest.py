import pytest

@pytest.fixture
def mock_payment_db(mocker):
        
    def _dynamic_response(user_id, status_code, recipient):
        status = "PAID" if status_code == 200 else "PENDING"
        return {"user_id": user_id, "payment_status": status, "query_time_ms": 10}

    yield mocker.patch("payments.query_payment_database", side_effect=_dynamic_response)