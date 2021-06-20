//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by coder on 19.05.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let launchVC = ModuleBuilder.createMain()
        let navBar = UINavigationController(rootViewController: launchVC)
        window?.backgroundColor = Backgrounds.darkGray
        window?.rootViewController = navBar
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().barTintColor = Backgrounds.darkGray
        UINavigationBar.appearance().tintColor = Color.orangeColor
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)

        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        let backImage = UIImage(named: "icon-back")
        UINavigationBar.appearance().backIndicatorImage = backImage!.stretchableImage(withLeftCapWidth: 0, topCapHeight: 110)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor:  Color.orangeColor, .font: UIFont.boldFont(ofSize: 20)]
        return true
        
    }
    
    

}

