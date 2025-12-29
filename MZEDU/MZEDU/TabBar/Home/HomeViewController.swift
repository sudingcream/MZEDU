import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    // MARK: - Top Search Area
    private let searchView = UIView()
    private let titleLabel = UILabel()
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

        // 🔵 searchView
        searchView.backgroundColor = UIColor(hex: "#2158E8")

        titleLabel.text = "주변 학원 둘러보기"
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.attributedText = NSAttributedString(
            string: titleLabel.text ?? "",
            attributes: [.kern: -1]
        )

        searchContainerView.backgroundColor = .white
        searchContainerView.layer.cornerRadius = 10

        searchIconImageView.image = UIImage(named: "searchIcon")
        searchIconImageView.contentMode = .scaleAspectFit

        placeholderLabel.text = "학원 이름이나 지역을 검색하세요"
        placeholderLabel.font = .systemFont(ofSize: 13, weight: .medium)
        placeholderLabel.textColor = UIColor(hex: "#AEAEB2")
        placeholderLabel.attributedText = NSAttributedString(
            string: placeholderLabel.text ?? "",
            attributes: [.kern: -1]
        )

        // Scroll
        contentStackView.axis = .vertical
        contentStackView.spacing = 20

        view.addSubview(searchView)
        view.addSubview(scrollView)

        searchView.addSubview(titleLabel)
        searchView.addSubview(searchContainerView)
        searchContainerView.addSubview(searchIconImageView)
        searchContainerView.addSubview(placeholderLabel)

        scrollView.addSubview(contentStackView)

        // 섹션 추가
        contentStackView.addArrangedSubview(makeSectionTitle("맞춤 추천"))
        contentStackView.addArrangedSubview(makeCardView(
            title: "대치 탑클래스 학원",
            subtitle: "서울시 강남구 대치동",
            description: "주 3회, 일 4시간 집중 케어 수업. 학생 개인별 맞춤형 지도와 철저한 성적 관리 시스템을 제공합니다."
        ))

        contentStackView.addArrangedSubview(makeSectionTitle("즐겨찾는 게시판"))
        contentStackView.addArrangedSubview(makeBoardView())

        contentStackView.addArrangedSubview(makeSectionTitle("최근 공지사항"))
        contentStackView.addArrangedSubview(makeNoticeView())
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
        let label = UILabel()
        label.text = title
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }

    func makeCardView(title: String, subtitle: String, description: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = .init(width: 0, height: 2)

        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.text = title

        let subtitleLabel = UILabel()
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .gray
        subtitleLabel.text = subtitle

        let descLabel = UILabel()
        descLabel.font = .systemFont(ofSize: 13)
        descLabel.textColor = .darkGray
        descLabel.numberOfLines = 0
        descLabel.text = description

        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, descLabel])
        stack.axis = .vertical
        stack.spacing = 6

        view.addSubview(stack)
        stack.snp.makeConstraints { $0.edges.equalToSuperview().inset(16) }

        return view
    }

    func makeBoardView() -> UIView {
        let label = UILabel()
        label.text = "자유게시판 / 비밀게시판"
        label.font = .systemFont(ofSize: 14)
        return label
    }

    func makeNoticeView() -> UIView {
        let label = UILabel()
        label.text = "서버 점검 안내 · 2시간 전"
        label.font = .systemFont(ofSize: 14)
        return label
    }
}
