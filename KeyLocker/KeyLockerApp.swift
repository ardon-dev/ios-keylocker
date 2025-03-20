//
//  KeyLockerApp.swift
//  KeyLocker
//
//  Created by Josue on 26/2/25.
//

import SwiftUI

@main
struct KeyLockerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    /* Defaults */
                    if !UserDefaults.standard.valueExists(forKey: KEY_FACEID_ENABLED) {
                        saveBoolDefault(true, key: KEY_FACEID_ENABLED)
                    }
                }
                .environment(\.managedObjectContext, KeyLockerCDataController.shared.context)
        }
    }
    
}
