import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    // MARK: - Top Search Area
    private let searchView = UIView()
    private var titleLabel = UILabel()
    private let searchContainerView = UIView()
    private let searchIconImageView = UIImageView()
    private let placeholderLabel = UILabel()

    // MARK: - Scroll Area
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
    }
}

// MARK: - UI Configuration
extension HomeViewController {

    private func configureUI() {
        view.backgroundColor = .white
        title = "홈"

        // 🔹 Top Search Area
        searchView.backgroundColor = UIColor(hex: "#2158E8")

        titleLabel = .styled(
            text: "주변 학원 둘러보기",
            font: .boldSystemFont(ofSize: 16),
            color: .white
        )

        searchContainerView.backgroundColor = .white
        searchContainerView.layer.cornerRadius = 10

        searchIconImageView.image = UIImage(named: "searchIcon")
        searchIconImageView.contentMode = .scaleAspectFit

        placeholderLabel.attributedText = NSAttributedString(
            string: "학원 이름이나 지역을 검색하세요",
            attributes: [
                .font: UIFont.systemFont(ofSize: 13, weight: .medium),
                .foregroundColor: UIColor(hex: "#AEAEB2"),
                .kern: -1
            ]
        )

        // 🔹 Scroll Area
        contentStackView.axis = .vertical
        contentStackView.spacing = 20

        // MARK: - View Hierarchy
        view.addSubview(searchView)
        view.addSubview(scrollView)

        searchView.addSubview(titleLabel)
        searchView.addSubview(searchContainerView)
        searchContainerView.addSubview(searchIconImageView)
        searchContainerView.addSubview(placeholderLabel)

        scrollView.addSubview(contentStackView)

        // MARK: - Content Sections

        // 1️⃣ 맞춤 추천
        contentStackView.addArrangedSubview(makeSectionTitle("맞춤 추천"))

        let academyCardView = makeCardView(
            title: "대치 탑클래스 학원",
            subtitle: "서울시 강남구 대치동",
            description: "주 3회, 일 4시간 집중 케어 수업. 학생 개인별 맞춤형 지도와 철저한 성적 관리 시스템을 제공합니다."
        )

        academyCardView.isUserInteractionEnabled = true
        academyCardView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(didTapAcademyCard)
            )
        )

        contentStackView.addArrangedSubview(academyCardView)

        // 2️⃣ 즐겨찾는 게시판
        contentStackView.addArrangedSubview(makeSectionTitle("즐겨찾는 게시판"))
        contentStackView.addArrangedSubview(makeBoardView())

        // 3️⃣ 최근 공지사항
        contentStackView.addArrangedSubview(makeSectionTitle("최근 공지사항"))
        contentStackView.addArrangedSubview(makeNoticeView())
    }
}


extension HomeViewController {
    @objc private func didTapAcademyCard() {
        let viewController = AcademyDetailViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

// MARK: - Layout
extension HomeViewController {

    private func setupLayout() {

        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(114)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        searchContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(41)
        }

        searchIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(23)
        }

        placeholderLabel.snp.makeConstraints {
            $0.leading.equalTo(searchIconImageView.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
            $0.width.equalToSuperview().offset(-40)
        }
    }
}

private extension HomeViewController {

    func makeSectionTitle(_ title: String) -> UILabel {
        UILabel.styled(
            text: title,
            font: .boldSystemFont(ofSize: 20)
        )
    }

    func makeCardView(
        title: String,
        subtitle: String,
        description: String
    ) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = .init(width: 0, height: 2)

        let titleLabel = UILabel.styled(
            text: title,
            font: .boldSystemFont(ofSize: 15)
        )

        let subtitleLabel = UILabel.styled(
            text: subtitle,
            font: .systemFont(ofSize: 13),
            color: .gray
        )

        let descLabel = UILabel.styled(
            text: description,
            font: .systemFont(ofSize: 13),
            color: .darkGray,
            numberOfLines: 0
        )

        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, descLabel])
        stack.axis = .vertical
        stack.spacing = 6

        view.addSubview(stack)
        stack.snp.makeConstraints { $0.edges.equalToSuperview().inset(16) }

        return view
    }

    func makeBoardView() -> UIView {
        UILabel.styled(
            text: "자유게시판 / 비밀게시판",
            font: .systemFont(ofSize: 14)
        )
    }

    func makeNoticeView() -> UIView {
        UILabel.styled(
            text: "서버 점검 안내 · 2시간 전",
            font: .systemFont(ofSize: 14)
        )
    }
}
