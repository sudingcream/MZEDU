import UIKit
import SnapKit
import MapKit

final class AcademyDetailViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let backButton = UIButton()
    
    private let titleLabel = UILabel()
    private let addressLabel = UILabel()
    private let divider = UIView()

    private let introTitleLabel = UILabel()
    private let introLabel = UILabel()

    private let locationTitleLabel = UILabel()
    private let mapView = MKMapView()

    private let reviewTitleLabel = UILabel()
    private let reviewStackView = UIStackView()

    private let reviewButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}

// MARK: - UI
extension AcademyDetailViewController {

    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = ""
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)

        titleLabel.text = "대치 탑클래스 학원"
        titleLabel.font = .boldSystemFont(ofSize: 22)

        addressLabel.text = "서울시 강남구 대치동"
        addressLabel.font = .systemFont(ofSize: 14)
        addressLabel.textColor = .gray

        divider.backgroundColor = UIColor(hex: "#E5E5EA")

        introTitleLabel.text = "학원 소개"
        introTitleLabel.font = .boldSystemFont(ofSize: 18)

        introLabel.text = "주 3회, 일 4시간 집중 케어 수업. 학생 개인별 맞춤형 지도와 철저한 성적 관리 시스템을 제공합니다."
        introLabel.font = .systemFont(ofSize: 14)
        introLabel.numberOfLines = 0

        locationTitleLabel.text = "위치 안내"
        locationTitleLabel.font = .boldSystemFont(ofSize: 18)

        mapView.layer.cornerRadius = 12
        mapView.clipsToBounds = true

        reviewTitleLabel.text = "수강생 리뷰"
        reviewTitleLabel.font = .boldSystemFont(ofSize: 18)

        reviewStackView.axis = .vertical
        reviewStackView.spacing = 16

        reviewStackView.addArrangedSubview(
            makeReviewCard(
                date: "2023.12.20",
                rating: 5,
                content: "수학 성적이 안 올라서 고민이었는데, 여기서 선생님이 알려주신 풀이법대로 하니까 이번 기말고사에서 20점이나 올랐어요!"
            )
        )

        reviewStackView.addArrangedSubview(
            makeReviewCard(
                date: "2024.02.20",
                rating: 4,
                content: "선생님들이 다들 너무 친절하세요. 가끔 숙제가 많을 때도 있지만 확실히 실력이 느는게 체감됩니다."
            )
        )

        reviewButton.setTitle("리뷰 남기기", for: .normal)
        reviewButton.backgroundColor = UIColor(hex: "#2158E8")
        reviewButton.setTitleColor(.white, for: .normal)
        reviewButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        reviewButton.layer.cornerRadius = 12
        reviewButton.addTarget(self, action: #selector(didTapWriteReview), for: .touchUpInside)

    }
}

extension AcademyDetailViewController {
    @objc private func didTapWriteReview() {
        let vc = WriteReviewViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

// MARK: - Layout
extension AcademyDetailViewController {

    private func setupLayout() {

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        contentView.addSubview(backButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(divider)
        contentView.addSubview(introTitleLabel)
        contentView.addSubview(introLabel)
        contentView.addSubview(locationTitleLabel)
        contentView.addSubview(mapView)
        contentView.addSubview(reviewTitleLabel)
        contentView.addSubview(reviewStackView)
        contentView.addSubview(reviewButton)

        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(32)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(titleLabel)
        }

        divider.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        introTitleLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(titleLabel)
        }

        introLabel.snp.makeConstraints {
            $0.top.equalTo(introTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(titleLabel)
        }

        locationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(introLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(titleLabel)
        }

        mapView.snp.makeConstraints {
            $0.top.equalTo(locationTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(titleLabel)
            $0.height.equalTo(180)
        }

        reviewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(titleLabel)
        }

        reviewStackView.snp.makeConstraints {
            $0.top.equalTo(reviewTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(titleLabel)
        }

        reviewButton.snp.makeConstraints {
            $0.top.equalTo(reviewStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(titleLabel)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
}

private extension AcademyDetailViewController {
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
}

// MARK: - Review Card
private extension AcademyDetailViewController {
    func makeReviewCard(
        date: String,
        rating: Int,
        content: String
    ) -> UIView {

        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = .init(width: 0, height: 2)

        let nameLabel = UILabel()
        nameLabel.text = "익명"
        nameLabel.font = .systemFont(ofSize: 13, weight: .medium)

        let starView = makeStarRatingView(rating: rating)

        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray

        let topStack = UIStackView(arrangedSubviews: [
            nameLabel,
            starView,
            UIView(),
            dateLabel
        ])
        topStack.axis = .horizontal
        topStack.alignment = .center
        topStack.spacing = 6

        let contentLabel = UILabel()
        contentLabel.text = content
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [topStack, contentLabel])
        stack.axis = .vertical
        stack.spacing = 10

        view.addSubview(stack)
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        return view
    }

}

private extension AcademyDetailViewController {
    
    private func makeStarRatingView(rating: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2

        for index in 0..<5 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = UIColor(hex: "#FFD600") // 노란 별

            let imageName = index < rating ? "star.fill" : "star"
            imageView.image = UIImage(systemName: imageName)

            imageView.snp.makeConstraints {
                $0.size.equalTo(14)
            }

            stackView.addArrangedSubview(imageView)
        }

        return stackView
    }

}
