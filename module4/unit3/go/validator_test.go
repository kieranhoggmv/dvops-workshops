package payment

import (
	"testing"
)

func TestValidator(t *testing.T) {
	// Validator Behaviors
	t.Run("Validator", func(t *testing.T) {
		// Rules 1 & 2
		tests := map[int]bool{101: true, -5: false, 0: false}
		for input, expected := range tests {
			res, _ := IsValidUserID(input)
			if res != expected {
				t.Errorf("For %d, expected %v, got %v", input, expected, res)
			}
		}

		// Rule 3
		invalidTypes := []any{"abc", 10.5, true, nil}
		for _, input := range invalidTypes {
			_, err := IsValidUserID(input)
			if err == nil || err.Error() != "User ID must be an integer." {
				t.Errorf("Expected integer type error for %v", input)
			}
		}
	})
}