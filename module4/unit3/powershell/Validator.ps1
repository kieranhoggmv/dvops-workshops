
function Test-UserIdValid {
    param($UserId)
    
    # Rule 3: Must be an integer
    if ($UserId -isnot [int]) { 
        throw "User ID must be an integer."
    }
    
    # Rules 1 & 2: Must be positive
    return ($UserId -gt 0)
}