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
