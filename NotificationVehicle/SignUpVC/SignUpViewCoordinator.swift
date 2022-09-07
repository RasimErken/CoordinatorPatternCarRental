//
//  FormValueModel.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 4.09.2022.
//


import UIKit


protocol SignInStartFlow: class {
    func coordinateToLogInVC()
    func coordinateToMainVC(email:String,password:String,name:String)
}

class SignUpCoordinator: Coordinator , SignInStartFlow {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let signUpViewController = SignUpVC()
        signUpViewController.coordinator = self


        navigationController.pushViewController(signUpViewController, animated: true)
        removeNavigation()
        
    }
    
    func coordinateToLogInVC() {
        let tabBarCoordinator = LogInCoordinator(navigationController: navigationController)
        coordinate(to: tabBarCoordinator)
    }
    func coordinateToMainVC(email:String,password:String,name:String) {
        
        AuthService.insance.createUser(withEmail: email, andPassword: password, andUsername: name) { success, error in
            if let error = error {
                print("SignUpError")
            } else {
                self.goToMainVC()
                NotificationClass.instance.notification(body: "You have signed up successfully ", notification: "SignUpNotification")
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
