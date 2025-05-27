import UIKit

//MARK: --- Task 1: Palindrome check
public func isPalindrome(input: String) -> Bool {

    let decomposed = input.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)

    var cleanedInput = ""
    for char in decomposed {
        if char.isLetter || char.isNumber {
            cleanedInput.append(char)
        }
    }

    if cleanedInput.count <= 1 {
        return false
    }

    let chars = Array(cleanedInput)
    var left = 0
    var right = chars.count - 1

    while left < right {
        if chars[left] != chars[right] {
            return false
        }
        left += 1
        right -= 1
    }

    return true
}
print(isPalindrome(input: "Ana"))
print(isPalindrome(input: "Áná"))

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

