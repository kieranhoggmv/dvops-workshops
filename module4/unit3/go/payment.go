package payment

// GetPaymentStatus behaves like the mock query: 
// Returns "PAID" if status is 200, otherwise "PENDING".
func GetPaymentStatus(userID int, statusCode int) map[string]any {
	status := "PENDING"
	if statusCode == 200 {
		status = "PAID"
	}
	return map[string]any{
		"user_id":        userID,
		"payment_status": status,
		"query_time_ms":  10,    
	}
}
