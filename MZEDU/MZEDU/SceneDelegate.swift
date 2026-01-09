import UIKit
import NidThirdPartyLogin
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)

        if AuthManager.shared.isLoggedIn {
            window.rootViewController = MainTabBarController()
        } else {
            window.rootViewController = LoginViewController()
        }

        self.window = window
        window.makeKeyAndVisible()
    }
    
    func scene(
         _ scene: UIScene,
         openURLContexts URLContexts: Set<UIOpenURLContext>
     ) {
         guard let url = URLContexts.first?.url else { return }
 
         if NidOAuth.shared.handleURL(url) {
             return
         }
         if AuthApi.isKakaoTalkLoginUrl(url) {
             _ = AuthController.handleOpenUrl(url: url)
             return
         }
     }
}
