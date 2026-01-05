import UIKit
import SnapKit

final class WriteReviewViewController: UIViewController {

    // MARK: - Header
    private let closeButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let submitButton = UIButton(type: .system)

    // MARK: - Academy Info
    private let academyTitleLabel = UILabel()
    private let academyAddressLabel = UILabel()
    private let divider = UIView()

    // MARK: - Rating
    private let ratingTitleLabel = UILabel()
    private let starStackView = UIStackView()
    private var selectedRating: Int = 5

    // MARK: - Review Input
    private let reviewTitleLabel = UILabel()
    private let reviewTextView = UITextView()
    private let placeholderLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
    }
}
extension WriteReviewViewController {

    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)

        // Header
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)

        titleLabel.text = "리뷰 남기기"
        titleLabel.font = .boldSystemFont(ofSize: 18)

        submitButton.setTitle("등록", for: .normal)
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        submitButton.setTitleColor(UIColor(hex: "#2158E8"), for: .normal)
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)

        // Academy Info
        academyTitleLabel.text = "대치 탑클래스 학원"
        academyTitleLabel.font = .boldSystemFont(ofSize: 20)

        academyAddressLabel.text = "서울시 강남구 대치동"
        academyAddressLabel.font = .systemFont(ofSize: 14)
        academyAddressLabel.textColor = .gray

        divider.backgroundColor = UIColor(hex: "#E5E5EA")

        // Rating
        ratingTitleLabel.text = "별점"
        ratingTitleLabel.font = .boldSystemFont(ofSize: 16)

        setupStarRating()

        // Review
        reviewTitleLabel.text = "수강생 리뷰"
        reviewTitleLabel.font = .boldSystemFont(ofSize: 16)

        reviewTextView.font = .systemFont(ofSize: 15)
        reviewTextView.layer.cornerRadius = 12
        reviewTextView.backgroundColor = UIColor(hex: "#F5F5F5")
        reviewTextView.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        reviewTextView.delegate = self

        placeholderLabel.text = "이 학원에 대한 리뷰를 남겨주세요!"
        placeholderLabel.font = .systemFont(ofSize: 14)
        placeholderLabel.textColor = UIColor(hex: "#B0B0B0")
    }
}
extension WriteReviewViewController {

    private func setupLayout() {

        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(submitButton)

        view.addSubview(academyTitleLabel)
        view.addSubview(academyAddressLabel)
        view.addSubview(divider)

        view.addSubview(ratingTitleLabel)
        view.addSubview(starStackView)

        view.addSubview(reviewTitleLabel)
        view.addSubview(reviewTextView)
        reviewTextView.addSubview(placeholderLabel)

        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(32)
        }

        submitButton.snp.makeConstraints {
            $0.centerY.equalTo(closeButton)
            $0.trailing.equalToSuperview().offset(-16)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(closeButton)
            $0.centerX.equalToSuperview()
        }

        academyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        academyAddressLabel.snp.makeConstraints {
            $0.top.equalTo(academyTitleLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(academyTitleLabel)
        }

        divider.snp.makeConstraints {
            $0.top.equalTo(academyAddressLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        ratingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }

        starStackView.snp.makeConstraints {
            $0.top.equalTo(ratingTitleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        reviewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(starStackView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(20)
        }

        reviewTextView.snp.makeConstraints {
            $0.top.equalTo(reviewTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(160)
        }

        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
    }
}
private extension WriteReviewViewController {

    func setupStarRating() {
        starStackView.axis = .horizontal
        starStackView.spacing = 8

        for index in 1...5 {
            let button = UIButton(type: .system)
            button.tag = index
            button.setImage(UIImage(systemName: "star.fill"), for: .normal)
            button.tintColor = UIColor(hex: "#FFD600")
            button.addTarget(self, action: #selector(didTapStar(_:)), for: .touchUpInside)

            button.snp.makeConstraints {
                $0.size.equalTo(32)
            }

            starStackView.addArrangedSubview(button)
        }
    }

    @objc func didTapStar(_ sender: UIButton) {
        selectedRating = sender.tag

        for case let button as UIButton in starStackView.arrangedSubviews {
            let imageName = button.tag <= selectedRating ? "star.fill" : "star"
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
extension WriteReviewViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }

    @objc private func didTapClose() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }

    @objc private func didTapSubmit() {
        print("⭐️ Rating:", selectedRating)
        print("📝 Review:", reviewTextView.text ?? "")
        navigationController?.popViewController(animated: true)
    }
}
