//
//  AuthManager.swift
//  MZEDU
//
//  Created by 수진잉 on 12/29/25.
//

// AuthManager.swift
import Foundation

final class AuthManager {

    static let shared = AuthManager()
    private init() {}

    var isLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")

        // 토큰 기반일때
        // return KeychainManager.shared.accessToken != nil
    }

    func login() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }

    func logout() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
}
