import UIKit
import NidThirdPartyLogin

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
    }
    
    func scene(
         _ scene: UIScene,
         openURLContexts URLContexts: Set<UIOpenURLContext>
     ) {
         guard let url = URLContexts.first?.url else { return }
 
         if NidOAuth.shared.handleURL(url) {
             return
         } 
     }
}
