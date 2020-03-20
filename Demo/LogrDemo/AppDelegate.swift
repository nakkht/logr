//
// Copyright 2020 Paulius Gudonis, neqsoft
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// 

import UIKit
import Logr

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private lazy var logr = Logr(String(describing: AppDelegate.self))
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        viewController.view = view
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        LogrService.init(with: Config(ConsoleTarget(ConsoleTargetConfig(style: .verbose)), FileTarget()))
        logr.info("Application did finish launch")
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
    
    @objc func logDebug(sender: UIButton!) {
        logr.debug("Debug button touched")
    }
    
    @objc func logInfo(sender: UIButton!) {
        logr.info("Info button touched")
    }
    
    @objc func logWarn(sender: UIButton!) {
        logr.warn("Warn button touched")
    }
    
    @objc func logError(sender: UIButton!) {
        logr.error("Error button touched")
    }
    
    @objc func logCritical(sender: UIButton!) {
        logr.critical("Critical button touched")
    }
    
    private lazy var debugButton: UIButton = {
        let button = UIButton()
        button.setTitle("Debug log", for: .normal)
        button.addTarget(self, action: #selector(logDebug), for: .touchUpInside)
        return button
    }()
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Info log", for: .normal)
        button.addTarget(self, action: #selector(logInfo), for: .touchUpInside)
        return button
    }()
    private lazy var warnButton: UIButton = {
        let button = UIButton()
        button.setTitle("Warn log", for: .normal)
        button.addTarget(self, action: #selector(logWarn), for: .touchUpInside)
        return button
    }()
    private lazy var errorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Error log", for: .normal)
        button.addTarget(self, action: #selector(logError), for: .touchUpInside)
        return button
    }()
    private lazy var criticalButton: UIButton = {
        let button = UIButton()
        button.setTitle("Critical log", for: .normal)
        button.addTarget(self, action: #selector(logCritical), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var viewController = UIViewController()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [debugButton,
                                                       infoButton,
                                                       warnButton,
                                                       errorButton,
                                                       criticalButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        return view
    }()
}
