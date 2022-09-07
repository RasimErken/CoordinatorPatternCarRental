//
//  FireBaseAuthService.swift
//  FireBaseVehicle
//
//  Created by rasim rifat erken on 23.08.2022.
//

import Foundation

import FirebaseAnalytics
import FirebaseAuth
import FirebaseStorage

class AuthService {
    static let insance = AuthService()
    
    
    func createUser(withEmail email : String, andPassword password: String, andUsername username: String, completion : @escaping(_ success: Bool, _ error : Error?)->()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                completion(true, nil)
            } else {
                print(error ?? "Couldn't create user")
                completion(false, error)
            }
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, completion : @escaping(_ success: Bool, _ error: Error?)->()){
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error == nil {
                
                completion(true, nil)
                return
            } else {
                print("Password wrong")
                completion(false, error)
            }
        }
            
    }
    
    func logoutUser(completion: @escaping(_ status : Bool) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(true)
            
        } catch {
            completion(false)
            print("SignOut failed")
        }
    }


}

