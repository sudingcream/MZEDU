//
//  LoginViewController.swift
//  MZEDU
//

import UIKit
import AVFoundation
import SnapKit
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKUser

final class LoginViewController: UIViewController {

    // MARK: - Video
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?

    // MARK: - UI
    private let headlineLabel = UILabel()
    private let brandLabel = UILabel()
 
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(
            UIImage(named: "kakao"),
            for: .normal
        )
        button.clipsToBounds = true
        return button
    }()

    private let appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(
            authorizationButtonType: .signIn,
            authorizationButtonStyle: .white
        )
        return button
    }()

    private let loginButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
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

        headlineLabel.text = """
        좋은 선생님과의
        연결이 성장을 만듭니다.
        성공적인 학습의 시작
        """
        headlineLabel.font = .systemFont(ofSize: 28)
        headlineLabel.textColor = .white
        headlineLabel.numberOfLines = 0

        brandLabel.text = "MZEDU"
        brandLabel.font = .systemFont(ofSize: 50, weight: .bold)
        brandLabel.textColor = .white

        view.addSubview(headlineLabel)
        view.addSubview(brandLabel)
        view.addSubview(loginButtonStackView)

        loginButtonStackView.addArrangedSubview(kakaoLoginButton)
        loginButtonStackView.addArrangedSubview(appleLoginButton)

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

        kakaoLoginButton.snp.makeConstraints {
            $0.width.equalTo(183)
            $0.height.equalTo(45)
        }

        appleLoginButton.snp.makeConstraints {
            $0.width.equalTo(183)
            $0.height.equalTo(45)
        }
    }
}

// MARK: - Actions
extension LoginViewController {

    private func setupActions() {
        kakaoLoginButton.addTarget(
            self,
            action: #selector(didTapKakaoLogin),
            for: .touchUpInside
        )

        appleLoginButton.addTarget(
            self,
            action: #selector(didTapAppleLogin),
            for: .touchUpInside
        )
    }
    @objc private func didTapKakaoLogin() {
        
        print("🟡 Kakao button tapped")
        print("🟡 isKakaoTalkLoginAvailable:", UserApi.isKakaoTalkLoginAvailable())
        KakaoLogin()
//        if UserApi.isKakaoTalkLoginAvailable() {
//            UserApi.shared.loginWithKakaoTalk { [weak self] _, error in
//                if let error = error {
//                    print("❌ 카카오 로그인 실패:", error)
//                } else {
//                    print("✅ 카카오 로그인 성공")
//                    self?.loginSuccess()
//                }
//            }
//        } else {
//            UserApi.shared.loginWithKakaoAccount { [weak self] _, error in
//                if let error = error {
//                    print("❌ 카카오 로그인 실패:", error)
//                } else {
//                    print("✅ 카카오 로그인 성공")
//                    self?.loginSuccess()
//                }
//            }
//        }
    }
    
    func kakaoLonginWithApp() {
        UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
            if let error = error {
                print("❌ 카카오 로그인 실패:", error)
            } else {
                print("✅ loginWithKakaoTalk success")
                print("token:", oauthToken?.accessToken ?? "")

                DispatchQueue.main.async {
                    self?.loginSuccess()
                }
            }
        }
    }

    func kakaoLoginWithAccount() {
        UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
            if let error = error {
                print("❌ 카카오 로그인 실패:", error)
            } else {
                print("✅ loginWithKakaoAccount success")
                print("token:", oauthToken?.accessToken ?? "")

                DispatchQueue.main.async {
                    self?.loginSuccess()
                }
            }
        }
    }
    func KakaoLogin() {
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡 앱으로 로그인 인증
            kakaoLonginWithApp()
        } else { // 카톡이 설치가 안 되어 있을 때
            // 카카오 계정으로 로그인
            kakaoLoginWithAccount()
        }
    }
    @objc private func didTapAppleLogin() {
        print("🍎 Apple login tapped")

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
        ) else { return }

        let player = AVPlayer(url: URL(fileURLWithPath: path))
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
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = scene.delegate as? SceneDelegate,
            let window = sceneDelegate.window
        else { return }

        let mainTabBarController = MainTabBarController()
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
 
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }

}

// MARK: - Apple Login Delegate
extension LoginViewController: ASAuthorizationControllerDelegate {

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        print("✅ Apple login success")
        loginSuccess()
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print("❌ Apple login failed:", error)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(
        for controller: ASAuthorizationController
    ) -> ASPresentationAnchor {
        view.window!
    }
}
