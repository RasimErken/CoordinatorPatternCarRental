//
//  2.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 31.08.2022.
//

import Foundation
import UIKit
import FirebaseAuth



class LoginVC: UIViewController  {
    
    
    var coordinator: LogInCoordinator?
    
    
    var email = "E-mail"

    let emailTextField : UITextField = {
        let field = UITextField(frame: CGRect(x: 40, y: 180, width: UIScreen.main.bounds.width - 80, height: 40))
        field.attributedPlaceholder = NSAttributedString(
            string: "E-mail",
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
    
    let loginBtn : UIButton = {
        let button = UIButton(frame: CGRect(x: 300, y: 300, width: 80, height: 80))
        button.setBackgroundImage(UIImage(named: "LogIn"), for: .normal)
        button.layer.cornerRadius = button.bounds.height / 2.0
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFill
        button.addTarget(nil, action: #selector(login), for: .touchUpInside)
        button.clipsToBounds = true
        
        return button
    }()
    
    let goToSignUpBtn : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 48, y: 300, width: 80, height: 80)
        button.setBackgroundImage(UIImage(named: "b"), for: .normal)
        button.layer.cornerRadius = button.bounds.height / 2.0
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFill
        
        
        button.addTarget(nil, action: #selector(goToSignUpVC), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.isUserInteractionEnabled = true
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: ["text": email])

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Image.png")!)
        
        

        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginBtn)
        view.addSubview(goToSignUpBtn)
        
        
    }
    
    
    
    @objc func login() {
        self.coordinator?.coordinateToMainVC(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @objc func goToSignUpVC(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: ["text": email])
        coordinator?.coordinateToSignInVC()
    }
    
}


