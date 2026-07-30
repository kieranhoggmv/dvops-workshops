def validate_user_id(user_id):
    """
    Validates a user ID based on TDD requirements.
    Rules:
    1. Returns True for a valid, positive integer ID.
    2. Returns False for a negative integer ID.
    3. Raises TypeError for non-integer inputs (string or float).
    """
    # Rule 3: Check for type first (Type Guard)
    # Use type() here not isintance() as boolean is actually a subclass of integer in Python
    if type(user_id) is not int:
        # Including a message aids debugging and meets test assertion
        raise TypeError("User ID must be an integer.")

    # Rule 1 & 2: Return True for positive, False for non-positive (which includes 0 and negatives).
    # Since Rule 2 explicitly asks for False on negative, and Rule 1 on positive,
    # we can use a single elegant boolean return.
    return user_id > 0
