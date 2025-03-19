//
//  Extensions.swift
//  KeyLocker
//
//  Created by Josue on 13/3/25.
//

import Foundation

func formatDate(_ date: Date, format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

func generateRandomPassword(length: Int = 8) -> String {
    let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let lower = "abcdefghijklmnopqrstuvwxyz"
    let digits = "0123456789"
    let specialChars = "!@$#?"
    
    let allChars = upper + lower + digits + specialChars
    
    let finalLength = max(length, 8)
    
    var password = ""
    var applies = false
    
    repeat {
        password = ""
        
        for _ in 0..<finalLength {
            let randomIndex = Int(arc4random_uniform(UInt32(allChars.count)))
            let character = allChars[allChars.index(allChars.startIndex, offsetBy: randomIndex)]
            password.append(character)
        }
        
        let hasUpper = password.contains { upper.contains($0) }
        let hasDigit = password.contains { digits.contains($0) }
        let hasSpecialChar = password.contains { specialChars.contains($0) }
        
        applies = hasUpper && hasDigit && hasSpecialChar
        
    } while !applies
    
    return password
}
