. .\Payment.ps1

Describe "Payment Behaviors" {
    
    Context "Integration" {
        It "Returns PAID on 200 status" {
            $res = Get-PaymentStatus -UserId 9001 -StatusCode 200
            $res.payment_status | Should Be "PAID"
        }
        
        It "Returns PENDING on 500 status" {
            $res = Get-PaymentStatus -UserId 9002 -StatusCode 500
            $res.payment_status | Should Be "PENDING"
        }
    }
}