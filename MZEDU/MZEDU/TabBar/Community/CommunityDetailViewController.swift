import UIKit
import SnapKit

final class CommunityDetailViewController: UIViewController {

    // MARK: - Scroll
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // MARK: - Header
    private let backButton = UIButton(type: .system)
    private let moreButton = UIButton(type: .system)
    private let divider = UIView()

    // MARK: - Post Info
    private let categoryLabel = UILabel()
    private let timeLabel = UILabel()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()

    // MARK: - Comment
    private let commentTitleLabel = UILabel()
    private let commentInputView = UIView()
    private let commentTextField = UITextField()
    private let commentSubmitButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
    }
}
extension CommunityDetailViewController {

    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)

        // Header
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)

        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .black

        divider.backgroundColor = UIColor(hex: "#E5E5EA")

        // Post
        categoryLabel.text = "초코쿠키"
        categoryLabel.font = .systemFont(ofSize: 14, weight: .medium)

        timeLabel.text = "방금전"
        timeLabel.font = .systemFont(ofSize: 13)
        timeLabel.textColor = .gray

        titleLabel.text = "대치동 수학학원 어디가 좋을까요?"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0

        contentLabel.text =
        """
        서울 대치동은 전국에서 손꼽히는 수학 명문 학원가로 유명합니다.
        수학 실력을 빠르게 향상시키고 싶은 학생과 학부모가 가장 먼저 떠올리는 지역 중 하나죠.

        하지만 선택지가 워낙 많아 “어디가 진짜 좋을까?” 고민이 많을 수밖에 없습니다. ㅜㅜ
        """
        contentLabel.font = .systemFont(ofSize: 15)
        contentLabel.textColor = UIColor(hex: "#3A3A3C")
        contentLabel.numberOfLines = 0

        commentTitleLabel.text = "댓글"
        commentTitleLabel.font = .boldSystemFont(ofSize: 18)

        // Comment Input
        commentInputView.backgroundColor = UIColor(hex: "#F5F5F5")
        commentInputView.layer.cornerRadius = 22

        commentTextField.placeholder = "댓글을 입력하세요..."
        commentTextField.font = .systemFont(ofSize: 14)

        commentSubmitButton.setTitle("등록", for: .normal)
        commentSubmitButton.setTitleColor(UIColor(hex: "#2158E8"), for: .normal)
        commentSubmitButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
    }
}
extension CommunityDetailViewController {

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
        contentView.addSubview(moreButton)
        contentView.addSubview(divider)

        contentView.addSubview(categoryLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(commentTitleLabel)

        view.addSubview(commentInputView)
        commentInputView.addSubview(commentTextField)
        commentInputView.addSubview(commentSubmitButton)

        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(32)
        }

        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(32)
        }

        divider.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(categoryLabel)
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(8)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(titleLabel)
        }

        commentTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-100)
        }

        commentInputView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
            $0.height.equalTo(44)
        }

        commentTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(commentSubmitButton.snp.leading).offset(-8)
        }

        commentSubmitButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
}
private extension CommunityDetailViewController {
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
}
