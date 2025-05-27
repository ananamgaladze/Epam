import UIKit

//MARK: --- Task 1: Palindrome check
public func isPalindrome(input: String) -> Bool {
    var cleanedInput = ""
    
    for char in input {
        if char.isLetter || char.isNumber {
            cleanedInput.append(char.lowercased())
        }
    }
    
    if cleanedInput.count <= 1 {
        return false
    }
    
    var left = 0
    var right = cleanedInput.count - 1
    let characters = Array(cleanedInput)
    
    while left < right {
        if characters[left] != characters[right] {
            return false
        }
        left += 1
        right -= 1
    }
    
    return true
}

print(isPalindrome(input: "Ana"))

//MARK: --- Task 2: BalancedParentheses
public func isBalancedParentheses(input: String) -> Bool {
    var balance = 0
    
    for char in input {
        switch char {
        case "(":
            balance += 1
        case ")":
            balance -= 1
            if balance < 0 {
                return false
            }
        default: continue
        }
    }
    return balance == 0
}

print(isBalancedParentheses(input: "(()}"))

