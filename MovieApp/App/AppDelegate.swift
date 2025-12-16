//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 16.12.2025.
//

import UIKit


class AppDelegate: UIResponder, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return AppDelegate.orientationLock
        }
}
