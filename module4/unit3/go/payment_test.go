package payment

import (
	"testing"
)

func TestPaymentBehavior(t *testing.T) {
	// Integration Behaviors
	t.Run("Integration", func(t *testing.T) {
		successRes := GetPaymentStatus(9001, 200)
		if successRes["payment_status"] != "PAID" {
			t.Errorf("Expected PAID, got %v", successRes["payment_status"])
		}

		failRes := GetPaymentStatus(9002, 500)
		if failRes["payment_status"] != "PENDING" {
			t.Errorf("Expected PENDING, got %v", failRes["payment_status"])
		}
	})
}