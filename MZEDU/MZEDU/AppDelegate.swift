//
//  AppDelegate.swift
//  MZEDU
//
//  Created by suding on 12/27/25.
//

import UIKit
import NidThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      NidOAuth.shared.initialize(
        appName: "MZEDU",
        clientId: "MY1zX3KQ6XkC0UmbR0Hl",
        clientSecret: "tjye2T2fhS",
        urlScheme: "www.medium.com/pozi"
      )
      
      return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
    }
}

