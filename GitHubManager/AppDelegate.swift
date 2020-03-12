//
//  AppDelegate.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 05/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationbar()
        setupInitialViewController()
        return true
    }
}

// MARK: Private Functions
extension AppDelegate {
    
    /// Sets the start ViewController
    private func setupInitialViewController(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        window?.makeKeyAndVisible()
    }
    
    /// Configures the deafault navigation bar state
    private func setupNavigationbar(){
        UINavigationBar.appearance().tintColor    = .white
        UINavigationBar.appearance().barTintColor = .appColor(.main)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
    }
}

