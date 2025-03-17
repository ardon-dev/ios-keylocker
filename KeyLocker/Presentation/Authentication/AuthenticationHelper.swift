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
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to unlock your Key"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
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
    }
    
}
