import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    private let searchView = UIView()
    private let titleLabel = UILabel()
    private let searchContainerView = UIView()
    private let searchIconImageView = UIImageView()
    private let placeholderLabel = UILabel()

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

        // searchView
        searchView.backgroundColor = UIColor(hex: "#2158E8")

        // title label
        titleLabel.text = "주변 학원 둘러보기"
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.attributedText = NSAttributedString(
            string: titleLabel.text ?? "",
            attributes: [.kern: -1]
        )

        // search container
        searchContainerView.backgroundColor = .white
        searchContainerView.layer.cornerRadius = 8

        // search icon
        searchIconImageView.image = UIImage(named: "searchIcon")
        searchIconImageView.contentMode = .scaleAspectFit

        // placeholder label
        placeholderLabel.text = "학원 이름이나 지역을 검색하세요"
        placeholderLabel.font = .systemFont(ofSize: 13, weight: .medium)
        placeholderLabel.textColor = UIColor(hex: "#AEAEB2")
        placeholderLabel.attributedText = NSAttributedString(
            string: placeholderLabel.text ?? "",
            attributes: [.kern: -1]
        )

        view.addSubview(searchView)
        searchView.addSubview(titleLabel)
        searchView.addSubview(searchContainerView)
        searchContainerView.addSubview(searchIconImageView)
        searchContainerView.addSubview(placeholderLabel)
    }

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
    }
}
