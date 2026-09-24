package payment

import "errors"

// IsValidUserID validates the ID based on the TDD rules.
func IsValidUserID(id any) (bool, error) {
	// Rule 3: Check for strict integer type
	val, isInt := id.(int)
	if !isInt {
		return false, errors.New("User ID must be an integer.")
	}
	// Rules 1 & 2: Return true if positive, false if zero or negative
	return val > 0, nil
}