import UIKit
import SnapKit

final class RegisterFinishViewController: UIViewController {

    private let iconContainerView = UIView()
    private let iconImageView = UIImageView()

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    private let homeButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
    }
}

// MARK: - UI
extension RegisterFinishViewController {

    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true

        // 아이콘 컨테이너
        iconContainerView.backgroundColor = UIColor(hex: "#EEF3FF")
        iconContainerView.layer.cornerRadius = 40

        iconImageView.image = UIImage(systemName: "clock")
        iconImageView.tintColor = UIColor(hex: "#4E74F9")

        // 타이틀
        titleLabel.text = "인증 서류 제출 완료!"
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black

        // 설명
        descriptionLabel.text =
        "소중한 정보를 안전하게 접수했습니다.\n운영팀에서 24시간 이내로 검토를 마칠 예정이에요."
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .gray
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0

        // 홈 버튼
        homeButton.setTitle("홈으로 이동", for: .normal)
        homeButton.backgroundColor = UIColor(hex: "#0B1320")
        homeButton.setTitleColor(.white, for: .normal)
        homeButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        homeButton.layer.cornerRadius = 28
        homeButton.addTarget(self, action: #selector(didTapHome), for: .touchUpInside)

        // hierarchy
        view.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)

        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(homeButton)
    }
}

// MARK: - Layout
extension RegisterFinishViewController {

    private func setupLayout() {

        iconContainerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
            $0.size.equalTo(80)
        }

        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(32)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconContainerView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(40)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(40)
        }

        homeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(56)
        }
    }
}

// MARK: - Action
extension RegisterFinishViewController {

    @objc private func didTapHome() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.selectedIndex = 0

        if let window = view.window {
            window.rootViewController = mainTabBarController
            window.makeKeyAndVisible()
        }
    }
}
