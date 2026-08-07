def mock_payment_database_query(user_id, status_code):
    """
    Simulates a database query for payment status.
    This mock assumes the database returns "PAID" if the status code is 200, 
    and "PENDING" otherwise.
    """
    if status_code == 200:
        return {"user_id": user_id, "payment_status": "PAID", "query_time_ms": 10}
    else:
        return {"user_id": user_id, "payment_status": "PENDING", "query_time_ms": 10}
