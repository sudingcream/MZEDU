//
//  LoginViewController.swift
//  MZEDU
//

import UIKit
import AVFoundation
import SnapKit
import AuthenticationServices

final class LoginViewController: UIViewController {

    // MARK: - Video
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?

    // MARK: - UI
    private let headlineLabel = UILabel()
    private let brandLabel = UILabel()

    private let naverLoginButton = UIButton()

    private let appleLoginButton: UIButton = {
        let button = UIButton(type: .system)

        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        let image = UIImage(systemName: "apple.logo", withConfiguration: config)

        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 27.5
        button.clipsToBounds = true

        return button
    }()


    private let loginButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupActions()
        setupBackgroundVideo()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }
}

// MARK: - UI
extension LoginViewController {

    private func configureUI() {
        view.backgroundColor = .black

        // 메인 문구
        headlineLabel.text = """
        좋은 선생님과의
        연결이 성장을 만듭니다.
        성공적인 학습의 시작
        """
        headlineLabel.font = .systemFont(ofSize: 28, weight: .regular)
        headlineLabel.textColor = .white
        headlineLabel.numberOfLines = 0
        headlineLabel.textAlignment = .left

        // 브랜드
        brandLabel.text = "MZEDU"
        brandLabel.font = .systemFont(ofSize: 50, weight: .bold)
        brandLabel.textColor = .white
        brandLabel.textAlignment = .left

        // 네이버 로그인
        naverLoginButton.setBackgroundImage(
            UIImage(named: "naver_circle"),
            for: .normal
        )
        naverLoginButton.clipsToBounds = true

        // hierarchy
        view.addSubview(headlineLabel)
        view.addSubview(brandLabel)
        view.addSubview(loginButtonStackView)

        loginButtonStackView.addArrangedSubview(naverLoginButton)
        loginButtonStackView.addArrangedSubview(appleLoginButton)

        // layout
        headlineLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(brandLabel.snp.top).offset(-12)
        }

        brandLabel.snp.makeConstraints {
            $0.leading.equalTo(headlineLabel)
            $0.bottom.equalTo(loginButtonStackView.snp.top).offset(-40)
        }

        loginButtonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }

        naverLoginButton.snp.makeConstraints {
            $0.width.height.equalTo(55)
        }

        appleLoginButton.snp.makeConstraints {
            $0.width.height.equalTo(55)
        }
    }
}

// MARK: - Actions
extension LoginViewController {

    private func setupActions() {
        naverLoginButton.addTarget(
            self,
            action: #selector(didTapNaverLogin),
            for: .touchUpInside
        )
        appleLoginButton.addTarget(
            self,
            action: #selector(didTapAppleLogin),
            for: .touchUpInside
        )
    }

    @objc private func didTapNaverLogin() {
        loginSuccess()
    }

    @objc private func didTapAppleLogin() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(
            authorizationRequests: [request]
        )
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

// MARK: - Background Video
extension LoginViewController {

    private func setupBackgroundVideo() {
        guard let path = Bundle.main.path(
            forResource: "login",
            ofType: "mp4"
        ) else {
            print("login.mp4 not found")
            return
        }

        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        player.isMuted = true
        player.actionAtItemEnd = .none

        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill

        view.layer.insertSublayer(layer, at: 0)

        self.player = player
        self.playerLayer = layer

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loopVideo),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )

        player.play()
    }

    @objc private func loopVideo() {
        player?.seek(to: .zero)
        player?.play()
    }
}

// MARK: - Login Result
extension LoginViewController {

    private func loginSuccess() {
        AuthManager.shared.login()

        guard
            let _ = view.window?.windowScene?.delegate as? SceneDelegate
        else { return }
    }
}

// MARK: - Apple Login Delegate
extension LoginViewController: ASAuthorizationControllerDelegate {

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let credential =
            authorization.credential as? ASAuthorizationAppleIDCredential {
            print("Apple login success:", credential.user)
            loginSuccess()
        }
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print("Apple login failed:", error)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(
        for controller: ASAuthorizationController
    ) -> ASPresentationAnchor {
        return view.window!
    }
}
