//
//  LoginViewController.swift
//  MZEDU
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {

    private let backImage = UIImageView(image: UIImage(named: "splashView"))
    private let loginButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupActions()
    }
}

// MARK: - UI
extension LoginViewController {

    private func configureUI() {
        view.backgroundColor = .white

        backImage.contentMode = .scaleAspectFill

        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 10

        view.addSubview(backImage)
        view.addSubview(loginButton)

        backImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            $0.height.equalTo(50)
        }
    }
}

// MARK: - Actions
extension LoginViewController {

    private func setupActions() {
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }

    @objc private func didTapLogin() {
        loginSuccess()
    }

    private func loginSuccess() {
        AuthManager.shared.login()

        guard
            let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate
        else { return }
 
    }
}
