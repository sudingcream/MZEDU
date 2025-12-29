import UIKit
import SnapKit

final class MyViewController: UIViewController {

    // MARK: - UI

    private let titleLabel = UILabel()

    private let infoContainerView = UIView()
    private let nameLabel = UILabel()
    private let subInfoLabel = UILabel()
    private let editButton = UIButton(type: .system)

    private let menuStackView = UIStackView()

    private let versionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
    }
}

// MARK: - UI Configuration
extension MyViewController {

    private func configureUI() {
        view.backgroundColor = .white

        // title
        titleLabel.text = "내 정보"
        titleLabel.font = .boldSystemFont(ofSize: 22)

        // user info
        nameLabel.text = "인천수능1등"
        nameLabel.font = .boldSystemFont(ofSize: 18)

        subInfoLabel.text = "고2 / 인천광역시 동중부"
        subInfoLabel.font = .systemFont(ofSize: 14)
        subInfoLabel.textColor = .gray

        editButton.setTitle("프로필 수정", for: .normal)
        editButton.setTitleColor(UIColor(hex: "#4E74F9"), for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        editButton.backgroundColor = UIColor(hex: "#EEF3FF")
        editButton.layer.cornerRadius = 14
        editButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)

        // menu stack
        menuStackView.axis = .vertical
        menuStackView.spacing = 0

        ["공지사항", "고객센터", "로그아웃"].forEach {
            menuStackView.addArrangedSubview(makeMenuRow(title: $0))
        }

        // version
        versionLabel.text = "버전 정보 1.0.0"
        versionLabel.font = .systemFont(ofSize: 12)
        versionLabel.textColor = .lightGray

        // hierarchy
        view.addSubview(titleLabel)
        view.addSubview(infoContainerView)
        view.addSubview(menuStackView)
        view.addSubview(versionLabel)

        infoContainerView.addSubview(nameLabel)
        infoContainerView.addSubview(subInfoLabel)
        infoContainerView.addSubview(editButton)
    }
}

// MARK: - Layout
extension MyViewController {

    private func setupLayout() {

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }

        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }

        subInfoLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(nameLabel)
            $0.bottom.equalToSuperview()
        }

        editButton.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }

        menuStackView.snp.makeConstraints {
            $0.top.equalTo(infoContainerView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview()
        }

        versionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}

// MARK: - Menu Row Factory
private extension MyViewController {
    func makeMenuRow(title: String) -> UIView {
        let container = UIView()
        let label = UILabel()
        let divider = UIView()

        label.text = title
        label.font = .systemFont(ofSize: 16, weight: .medium)

        divider.backgroundColor = UIColor(hex: "#EDEDED")

        container.addSubview(label)
        container.addSubview(divider)

        container.snp.makeConstraints {
            $0.height.equalTo(56)
        }

        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }

        divider.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        // ✅ tap gesture 추가
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapMenu(_:))
        )
        container.addGestureRecognizer(tap)
        container.isUserInteractionEnabled = true
        container.accessibilityLabel = title

        return container
    }

    @objc private func didTapMenu(_ sender: UITapGestureRecognizer) {
        guard let title = sender.view?.accessibilityLabel else { return }

        switch title {
        case "고객센터":
            let vc = CustomerCenterViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        case "로그아웃":
            print("로그아웃")

        case "공지사항":
            print("공지사항")

        default:
            break
        }
    }

}
