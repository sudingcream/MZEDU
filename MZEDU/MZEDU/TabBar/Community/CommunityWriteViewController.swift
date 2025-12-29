import UIKit
import SnapKit

final class CommunityWriteViewController: UIViewController {
    // MARK: - Property
    private var selectedBoard: BoardType = .free

    // MARK: - UI Components
    private let closeButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let submitButton = UIButton(type: .system)

    private let divider = UIView()

    private let boardTitleLabel = UILabel()
    private let boardSelectView = UIView()
    private let boardSelectLabel = UILabel()

    private let titleTextField = UITextField()
    private let contentTextView = UITextView()
    private let contentPlaceholderLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
        setupActions()
    }
}

extension CommunityWriteViewController {

    private func configureUI() {
        view.backgroundColor = .white

        // close button
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black

        // title
        titleLabel.text = "글쓰기"
        titleLabel.font = .boldSystemFont(ofSize: 17)

        // submit button
        submitButton.setTitle("등록", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = UIColor(hex: "#E6ECFF")
        submitButton.layer.cornerRadius = 14
        submitButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        submitButton.isEnabled = false

        divider.backgroundColor = UIColor(hex: "#EDEDED")

        // board label
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBoardSelect))
        boardSelectView.addGestureRecognizer(tapGesture)
        boardSelectView.isUserInteractionEnabled = true

        boardTitleLabel.text = "게시판 선택"
        boardTitleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        boardTitleLabel.textColor = .gray

        // board select
        boardSelectView.backgroundColor = UIColor(hex: "#F5F6F8")
        boardSelectView.layer.cornerRadius = 10

        boardSelectLabel.text = "자유게시판"
        boardSelectLabel.font = .systemFont(ofSize: 15, weight: .medium)

        // title textfield
        titleTextField.placeholder = "제목을 입력하세요"
        titleTextField.font = .systemFont(ofSize: 16)
        titleTextField.borderStyle = .none

        // content textView
        contentTextView.font = .systemFont(ofSize: 15)
        contentTextView.delegate = self

        contentPlaceholderLabel.text =
        "학원 친구들과 나누고 싶은 이야기를 적어보세요.\n(타인을 비방하거나 부적절한 내용은 제재될 수 있습니다.)"
        contentPlaceholderLabel.font = .systemFont(ofSize: 14)
        contentPlaceholderLabel.textColor = UIColor(hex: "#C7C7CC")
        contentPlaceholderLabel.numberOfLines = 0

        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(submitButton)
        view.addSubview(divider)

        view.addSubview(boardTitleLabel)
        view.addSubview(boardSelectView)
        boardSelectView.addSubview(boardSelectLabel)

        view.addSubview(titleTextField)
        view.addSubview(contentTextView)
        contentTextView.addSubview(contentPlaceholderLabel)
    }
}
extension CommunityWriteViewController {

    private func setupLayout() {

        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(closeButton)
            $0.centerX.equalToSuperview()
        }

        submitButton.snp.makeConstraints {
            $0.centerY.equalTo(closeButton)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalTo(56)
            $0.height.equalTo(28)
        }

        divider.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        boardTitleLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }

        boardSelectView.snp.makeConstraints {
            $0.top.equalTo(boardTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }

        boardSelectLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }

        titleTextField.snp.makeConstraints {
            $0.top.equalTo(boardSelectView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }

        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }

        contentPlaceholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(4)
            $0.trailing.equalToSuperview()
        }
    }
}
extension CommunityWriteViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        contentPlaceholderLabel.isHidden = !textView.text.isEmpty
    }
}
extension CommunityWriteViewController {

    private func setupActions() {
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }

    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    @objc private func didTapBoardSelect() {
        let alert = UIAlertController(
            title: "게시판 선택",
            message: nil,
            preferredStyle: .actionSheet
        )

        let freeAction = UIAlertAction(title: "자유게시판", style: .default) { [weak self] _ in
            self?.selectBoard(.free)
        }

        let secretAction = UIAlertAction(title: "비밀게시판", style: .default) { [weak self] _ in
            self?.selectBoard(.secret)
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(freeAction)
        alert.addAction(secretAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

    private func selectBoard(_ board: BoardType) {
        selectedBoard = board
        boardSelectLabel.text = board.title

        if board == .secret {
            boardSelectView.backgroundColor = UIColor(hex: "#EFEFFF")
        } else {
            boardSelectView.backgroundColor = UIColor(hex: "#F5F6F8")
        }
    }

}
