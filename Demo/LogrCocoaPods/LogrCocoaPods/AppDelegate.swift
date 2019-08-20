//
//  AppDelegate.swift
//  LogrCocoaPods
//
//  Created by Paulius Gudonis on 20/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import UIKit
import Logr

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var logr = Logr()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LogrService.init(with: Config(ConsoleTarget()))
        logr.info("Application did finish launch")
        logr.warn("While using Cocoa pods")
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        logr.info("Application did become active")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        logr.info("Application will resign active")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        logr.info("Application did enter background")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        logr.info("Application will enter foreground")
    }
}
