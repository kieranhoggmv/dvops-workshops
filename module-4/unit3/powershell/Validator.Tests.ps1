. .\Validator.ps1

Describe "Validator Behaviors" {
Context "Validation Rules" {
        It "Rule 1: Returns True for positive IDs" { 
            Test-UserIdValid -UserId 101 | Should Be $true 
        }
        
        It "Rule 2: Returns False for negative IDs" { 
            Test-UserIdValid -UserId (-5) | Should Be $false 
        }
        
        It "Implicit: Returns False for zero" { 
            Test-UserIdValid -UserId 0 | Should Be $false 
        }
        
        It "Rule 3: Throws error for non-integers" -TestCases @(
            @{ Val = "abc" }; @{ Val = 10.5 }; @{ Val = $true }; @{ Val = $null }
        ) {
            param($Val)
            { Test-UserIdValid -UserId $Val } | Should Throw "User ID must be an integer."
        }
    }
}