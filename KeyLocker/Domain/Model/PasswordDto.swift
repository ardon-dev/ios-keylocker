//
//  Password.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import Foundation

struct PasswordDto: Identifiable {
    var id = UUID()
    var alias: String
    var password: String
}
