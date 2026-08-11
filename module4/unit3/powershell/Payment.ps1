function Get-PaymentStatus {
    param($UserId, $StatusCode)
    
    # Behavior: "PAID" if 200, "PENDING" otherwise
    $status = if ($StatusCode -eq 200) { "PAID" } else { "PENDING" }
    
    return @{ 
        user_id = $UserId;
        payment_status = $status;
        query_time_ms = 10
    }
}
