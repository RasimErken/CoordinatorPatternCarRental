//
//  1.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 31.08.2022.
//

import Foundation
import UIKit
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import FirebaseCore
import CryptoKit


class SignUpVC: UIViewController  {
    
    var email : String?
    
    var coordinator : SignUpCoordinator?
        
    var currentNonce : String?
    
    let nameTextField : UITextField = {
        let field = UITextField(frame: CGRect(x: 40, y: 120, width: UIScreen.main.bounds.width - 80, height: 40))
        field.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        )
        field.alpha = 0.5
        field.backgroundColor = .white
        field.layer.cornerRadius = 20
        field.textAlignment = .center
        field.textColor = .darkText
        return field
    }()
    
    let emailTextField : UITextField = {
        let field = UITextField(frame: CGRect(x: 40, y: 180, width: UIScreen.main.bounds.width - 80, height: 40))
        field.attributedPlaceholder = NSAttributedString(
            string: "E-mail" ,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        )
        field.alpha = 0.5
        field.backgroundColor = .white
        field.layer.cornerRadius = 20
        field.textAlignment = .center
        field.textColor = .darkText
        return field
    }()
    
    let passwordTextField : UITextField = {
        let field = UITextField(frame: CGRect(x: 40, y: 240, width: UIScreen.main.bounds.width - 80, height: 40))
        field.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        )
        field.alpha = 0.5
        field.backgroundColor = .white
        field.layer.cornerRadius = 20
        field.textAlignment = .center
        field.textColor = .darkText
        
        return field
    }()
    
    let signUpButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 300, y: 300, width: 80, height: 80))
        
        button.setBackgroundImage(UIImage(named: "b"), for: .normal)
        button.layer.cornerRadius = button.bounds.height / 2.0
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFill
        button.addTarget(nil, action: #selector(signUp), for: .touchUpInside)
        button.clipsToBounds = true
        
        return button
    }()
    
    let goToLoginBtn : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 48, y: 300, width: 80, height: 80)
        
        button.setBackgroundImage(UIImage(named: "BackButton"), for: .normal)
        button.layer.cornerRadius = button.bounds.height / 2.0
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFill
        
        
        button.addTarget(nil, action: #selector(goToLoginButoon), for: .touchUpInside)
        return button
    }()
    
    let googleSignUpButton : UIButton = {
        let button = UIButton (frame: CGRect(x: 60, y: 670, width: 300, height: 60))
        
        button.setBackgroundImage(UIImage(named: "google"), for: .normal)
        //button.layer.cornerRadius = button.bounds.height / 2.0
        button.layer.cornerRadius = 15
        //button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFill
        
        button.addTarget(nil, action: #selector(googleButton), for: .touchUpInside)
        return button
    }()
    
    let appleSignUpButton : ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton (frame: CGRect(x: 60, y: 750, width: 300, height: 60))
        
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFill
        
        button.addTarget(nil, action: #selector(appleButton), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.incomingNotification(_:)), name:  NSNotification.Name(rawValue: "notificationName"), object: nil)
        
        
    }
    
    
    
    @objc func incomingNotification(_ notification: Notification) {
        if let text = notification.userInfo?["text"] as? String {
            print(text)
            self.email = text
            print(email)
        }
    }
    

    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Image.png")!)
        
        appleSignUpButton.frame = CGRect(x: 60, y: 750, width: 300, height: 60)
        

        
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(googleSignUpButton)
        view.addSubview(goToLoginBtn)
        view.addSubview(appleSignUpButton)

    }
    
    @objc func signUp() {
        self.coordinator?.coordinateToMainVC(email: emailTextField.text!, password: passwordTextField.text!, name: nameTextField.text!)
    }

    
    @objc func goToLoginButoon() {
        coordinator?.coordinateToLogInVC()

        
    }
    
    @objc func googleButton() {
        NotificationClass.instance.notification(body: "You're in google sign up section now", notification: "Google Sing Up Notification")
        if let clientID = FirebaseApp.app()?.options.clientID {
            GIDSignIn.sharedInstance.signIn(with: .init(clientID: clientID) , presenting: UIApplication.shared.rootController()) { [self] user , error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }else {
                    logGoogleUser(user: user!)
                    NotificationClass.instance.notification(body: "You have signed up successfully", notification: "Google Sing Up Notification")
//                    goToLoginVC()
                    
                    
                }
                
            }
        }
        
    }
    
    func logGoogleUser(user:GIDGoogleUser) {
        Task {
            do {
                guard let idToken = user.authentication.idToken else {return}
                let accessToken = user.authentication.accessToken
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,  accessToken: accessToken)
                try await Auth.auth().signIn(with: credential)
                print("Success Google")
                
            } catch {
                print("error")
            }
        }
    }
    
    @objc func appleButton() {
        let request = appleRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
        
    }
    
    func appleRequest() -> ASAuthorizationAppleIDRequest  {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        return request
    }
    
    func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
        }.joined()

        return hashString
    }
    

}

extension UIApplication {
    func rootController() -> UIViewController {
        guard let window = connectedScenes.first as? UIWindowScene else {return .init()}
        guard let viewController = window.windows.last?.rootViewController else {return .init()}
        return viewController
    }
    
}

extension SignUpVC : ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        
        
        
        return view.window!
        
    }
    
    
}

extension SignUpVC : ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
           guard let nonce = currentNonce else {
               fatalError("Invalid state: A login callback was received, but no login request was sent.")
             }
            guard let appleIDToken = appleIDCredential.identityToken else {
                
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
                
                  
           }
                // Initialize a Firebase credential.
               let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken:idTokenString,rawNonce: nonce)
              // Sign in with Firebase.
               Auth.auth().signIn(with: credential) { (authResult, error) in
                   
                   if (error != nil) {
                      print(error?.localizedDescription)
                   return
                  
                   }
               }
            
            
        }
    
     }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
        
    }
}

