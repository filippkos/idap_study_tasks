//
//  AppDelegate.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 30.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: -
    // MARK: Variables
    
    private let window = UIWindow()
    private var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.prepareRootController()
        
        return true
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareRootController() {
        let navigationController = UINavigationController()
        self.coordinator = AppCoordinator(navigationViewController: navigationController)
        
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}

