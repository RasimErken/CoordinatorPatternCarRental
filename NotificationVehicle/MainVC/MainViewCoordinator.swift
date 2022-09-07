//
//  Protocol.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 1.09.2022.
//
import UIKit

protocol MainViewInStartFlow: class {
    func coordinateToLogInVC()
}

class MainViewCoordinator: Coordinator , MainViewInStartFlow {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController()
        mainViewController.coordinator = self
        
        navigationController.pushViewController(mainViewController, animated: true)
        removeNavigation()
        
    }
    
    func coordinateToLogInVC() {
        AuthService.insance.logoutUser { [self] status in
            goToLoginVC()
        }
        

    }
    func goToLoginVC() {
        let logInCoordinator = LogInCoordinator(navigationController: navigationController)
        coordinate(to: logInCoordinator)
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
