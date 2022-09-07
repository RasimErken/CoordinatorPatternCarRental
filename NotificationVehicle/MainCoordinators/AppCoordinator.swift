//
//  AppCoordinateble.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 4.09.2022.
//

import UIKit
import FirebaseAuth

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            let mainCoordinator = MainViewCoordinator(navigationController: navigationController)
            coordinate(to: mainCoordinator)
        } else {
            let logInCoordinator = LogInCoordinator(navigationController: navigationController)
            coordinate(to: logInCoordinator)
        }
        
        
    }
}
