import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        if AuthManager.shared.isLoggedIn {
            window?.rootViewController = MainTabBarController()
        } else {
            window?.rootViewController = MainTabBarController()
        }

        window?.makeKeyAndVisible()
    }
}
