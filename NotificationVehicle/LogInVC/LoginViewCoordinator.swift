//
//  vccoordinator.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 5.09.2022.
//
import UIKit
import FirebaseAuth

protocol StartFlow: class {
    func coordinateToSignInVC()
    func coordinateToMainVC(email:String , password:String)
}

class LogInCoordinator: Coordinator , StartFlow {
    
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let logInViewController = LoginVC()
        logInViewController.coordinator = self
        navigationController.pushViewController(logInViewController, animated: true)
        removeNavigation()
        
    }
    
    func coordinateToSignInVC() {
        let signUpCoordinator = SignUpCoordinator(navigationController: navigationController)
        coordinate(to: signUpCoordinator)
        
    }
    func coordinateToMainVC(email:String , password:String) {
        AuthService.insance.loginUser(withEmail: email, andPassword: password) { success, error in
            if let error = error {
                print("a")
                NotificationClass.instance.notification(body: "E-mail or Password is not correct", notification: "Notification")
            } else  {
                self.goToMainVC()
                NotificationClass.instance.notification(body: "You have logged up successfully", notification: "Log In Notification")
            }
        }
    }
    func goToMainVC() {
        let mainViewCoordinator = MainViewCoordinator(navigationController: navigationController)
        coordinate(to: mainViewCoordinator)
    }
    
    func removeNavigation() {
        let navigationController = self.navigationController
        var navigationArray = navigationController.viewControllers 
        let temp = navigationArray.last
        navigationArray.removeAll()
        navigationArray.append(temp!)
        self.navigationController.viewControllers = navigationArray
    }
}
