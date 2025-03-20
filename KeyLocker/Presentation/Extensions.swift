//
//  Extensions.swift
//  KeyLocker
//
//  Created by Josue on 13/3/25.
//

import Foundation
import UIKit

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

func appIcons() -> [String] {
    return [
        "apple",
        "instagram",
        "telegram",
        "github",
        "spotify",
        "linkedin",
        "microsoft",
        "facebook",
        "google"
    ]
}

func openWeb(url: String) {
    if let url = URL(string: url) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Can't open URL.")
        }
    }
}

func getAppVersion() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
}

/* User defaults */

let KEY_FACEID_ENABLED = "face_id_enabled"

func saveBoolDefault(_ value: Bool, key: String) {
    UserDefaults.standard.set(value, forKey: key)
}

func readBoolDefault(_ key: String) -> Bool {
    return UserDefaults.standard.bool(forKey: key)
}

extension UserDefaults {
    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
