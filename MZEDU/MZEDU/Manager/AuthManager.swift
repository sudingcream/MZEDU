import Foundation

final class AuthManager {

    static let shared = AuthManager()
    private init() {}

    private let isLoggedInKey = "isLoggedIn"

    var isLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: isLoggedInKey)
    }

    func login() {
        UserDefaults.standard.set(true, forKey: isLoggedInKey)
    }

    func logout() {
        UserDefaults.standard.set(false, forKey: isLoggedInKey)
    }
}
