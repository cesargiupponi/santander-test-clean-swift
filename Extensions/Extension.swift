//
//  Protocol.swift
//  santander-test-clean-swift
//
//  Created by Cesar Giupponi Paiva on 12/04/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import Foundation

extension StringProtocol {
    
    func isValidCPF() -> Bool {
        let numbers = compactMap({ Int(String($0)) })
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        
        func digitCalculator(_ slice: ArraySlice<Int>) -> Int {
            var number = slice.count + 2
            let digit = 11 - slice.reduce(into: 0) {
                number -= 1
                $0 += $1 * number
                } % 11
            return digit > 9 ? 0 : digit
        }
        
        let dv1 = digitCalculator(numbers.prefix(9))
        let dv2 = digitCalculator(numbers.prefix(10))
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = Regex.email.rawValue
        let emailValidate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValidEmail = emailValidate.evaluate(with: self)
        return isValidEmail
    }
    
    func isValidPassword() -> Bool {
        let emailRegex = Regex.password.rawValue
        let emailValidate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValidEmail = emailValidate.evaluate(with: self)
        return isValidEmail
    }
    
    var shortDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_br")
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter.string(from: Date())
    }
    
    func maskAgency() -> String {
        if self.isNumeric {
            var characters = Array(self)
            characters.insert(".", at: 2)
            characters.insert("-", at: 9)
            return String(characters)
        } else {
            return String(self)
        }
    }
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    func isEmpty() -> Bool {
        return self.isEmpty
    }
    
    func isNumber() -> Bool {
        for currentCharacter in self {
            if currentCharacter.isNumber {
                return true
            }
        }
        return false
    }
    
    func containsUpperCase() -> Bool {
        let upperCase = CharacterSet.uppercaseLetters
        
        for currentCharacter in self.unicodeScalars {
            if upperCase.contains(currentCharacter) {
                return true
            }
        }
        return false
    }
    
    func containsSpecialCharacteres() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", ".*[^A-Za-z0-9].*").evaluate(with: self)
    }
}

extension Double {
    var currency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_br")
        return formatter.string(from: NSNumber(value: self))!
    }
}
