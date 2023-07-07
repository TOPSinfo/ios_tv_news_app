//
//  AppDelegate.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpApp()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func setUpApp(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let homeVC = getViewController("HomeVC", onStoryboard: "Main")
        homeVC.tabBarItem.title = "Home"
            
//        let searchVC = getViewController("SearchVC", onStoryboard: "Main")
//        searchVC.tabBarItem.title = "Search"

        let videosVC = getViewController("VideosVC", onStoryboard: "Main")
        videosVC.tabBarItem.title = "Videos"

        let EpaperVC = getViewController("EpaperVC", onStoryboard: "Main")
        EpaperVC.tabBarItem.title = "E-Paper"
        
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [homeVC, videosVC, EpaperVC]
        self.window?.rootViewController = tabbarController
        self.window?.makeKeyAndVisible()
    }

}

