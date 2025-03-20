//
//  AuthenticationHelper.swift
//  KeyLocker
//
//  Created by Josue on 13/3/25.
//

import Foundation
import LocalAuthentication

class AuthenticationHelper {
    
    let context = LAContext()
    var error: NSError?
    
    func authenticate(closure: @escaping (Result<Bool, Error>) -> Void) {
        let faceIdEnabled = readBoolDefault(KEY_FACEID_ENABLED)
        print("enabled: \(faceIdEnabled)")
        let reason = "Authenticate to unlock your Key"
        
        if faceIdEnabled {
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authError in
                    DispatchQueue.main.async {
                        if success {
                            closure(.success(true))
                        } else {
                            if let authError = authError {
                                closure(.failure(authError))
                            } else {
                                closure(.failure(NSError(domain: "Authentication Error", code: -1, userInfo: nil)))
                            }
                        }
                    }
                }
            } else {
                if let error = error {
                    closure(.failure(error))
                } else {
                    closure(.failure(NSError(domain: "Authentication Error", code: -1, userInfo: nil)))
                }
            }
        } else {
            closure(.success(true))
        }
    }
    
}
