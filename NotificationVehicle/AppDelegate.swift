//
//  AppDelegate.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 31.08.2022.
//

import UIKit
import FirebaseCore
import GoogleSignIn




@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate   {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?
    

    
    
    
    func userNotificationCenter(
            _ center: UNUserNotificationCenter,
            willPresent notification: UNNotification,
            withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
            -> Void) {
            completionHandler([.alert, .badge, .sound])
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()

        
        coordinator = AppCoordinator(window: window!)
        coordinator?.start()

        return true
    }
    
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handle = GIDSignIn.sharedInstance.handle(url)
        return handle
        
    }
    

    
    
}



