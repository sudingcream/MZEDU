import UIKit
import SnapKit

final class CustomerCenterViewController: UIViewController {

    // MARK: - UI

    private let iconContainerView = UIView()
    private let mailIconImageView = UIImageView()

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    private let infoContainerView = UIView()
    private let infoLabel = UILabel()

    private let mailButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
        setupNavigation()
    }
}

// MARK: - UI Configuration
extension CustomerCenterViewController {

    private func configureUI() {
        view.backgroundColor = .white

        // icon container
        iconContainerView.backgroundColor = UIColor(hex: "#EEF3FF")
        iconContainerView.layer.cornerRadius = 48

        mailIconImageView.image = UIImage(systemName: "envelope")
        mailIconImageView.tintColor = UIColor(hex: "#4E74F9")
        mailIconImageView.contentMode = .scaleAspectFit

        // title
        titleLabel.text = "도움이 필요하신가요?"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center

        // description
        descriptionLabel.text =
        """
        운영진에게 직접 메일을 보내 문의할 수 있습니다.
        최대한 빠르게 확인 후 답변 드릴게요.
        """
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0

        // info box
        infoContainerView.backgroundColor = UIColor(hex: "#F4F7FF")
        infoContainerView.layer.cornerRadius = 14

        infoLabel.text =
        """
        안내사항

        평일 10:00 ~ 18:00 (주말/공휴일 제외)
        메일 전송 시 사용중인 기기 정보가 포함되면
        빠른 문제 해결이 가능합니다.
        """
        infoLabel.font = .systemFont(ofSize: 14)
        infoLabel.textColor = UIColor(hex: "#4E74F9")
        infoLabel.numberOfLines = 0

        // mail button
        mailButton.setTitle("운영자에게 메일 쓰기", for: .normal)
        mailButton.setTitleColor(.white, for: .normal)
        mailButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        mailButton.backgroundColor = UIColor(hex: "#2F5BEA")
        mailButton.layer.cornerRadius = 14

        // hierarchy
        view.addSubview(iconContainerView)
        iconContainerView.addSubview(mailIconImageView)

        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)

        view.addSubview(infoContainerView)
        infoContainerView.addSubview(infoLabel)

        view.addSubview(mailButton)
    }
}

// MARK: - Layout
extension CustomerCenterViewController {

    private func setupLayout() {

        iconContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(96)
        }

        mailIconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(40)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconContainerView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(32)
        }

        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        infoLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        mailButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(56)
        }
    }
}

// MARK: - Navigation
extension CustomerCenterViewController {

    private func setupNavigation() {
        title = "고객센터"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(didTapBack)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}
