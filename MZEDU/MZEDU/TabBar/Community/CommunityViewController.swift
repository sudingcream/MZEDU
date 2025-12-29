
import UIKit
import SnapKit

final class CommunityViewController: UIViewController {

    private let titleLabel = UILabel()
    private let writeButton = UIButton(type: .system)

    private let categoryStackView = UIStackView()
    private let tableView = UITableView()

    private let categories = ["전체", "자유게시판", "비밀게시판"]
    private var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
        setupTableView()
    }
}

// MARK: - Actions
extension CommunityViewController {

    @objc private func didTapWrite() {
        let writeVC = CommunityWriteViewController()
        writeVC.modalPresentationStyle = .fullScreen
        present(writeVC, animated: true)
    }

    @objc private func didTapCategory(_ sender: UIButton) {
        selectedIndex = sender.tag

        categoryStackView.arrangedSubviews.enumerated().forEach { index, view in
            guard let button = view as? UIButton else { return }

            let isSelected = index == selectedIndex
            button.backgroundColor = isSelected ? UIColor(hex: "#4E74F9") : UIColor(hex: "#F2F2F2")
            button.setTitleColor(isSelected ? .white : .gray, for: .normal)
        }

        tableView.reloadData()
    }
}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {

    private func setupTableView() {
        tableView.register(
            CommunityPostCell.self,
            forCellReuseIdentifier: "CommunityPostCell"
        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CommunityPostCell",
            for: indexPath
        ) as? CommunityPostCell else {
            return UITableViewCell()
        }

        cell.configure(
            type: indexPath.row % 2 == 0 ? "자유게시판" : "비밀게시판",
            title: "대치동 수학학원 어디가 좋을까요?",
            content: "이번에 중학교 올라가는데 친구들 따라 다니긴 싫네요..",
            time: "\(indexPath.row + 1)분전",
            likeCount: 12
        )

        return cell
    }
}

extension CommunityViewController {

    private func configureUI() {
        view.backgroundColor = .white

        // title
        titleLabel.text = "커뮤니티"
        titleLabel.font = .boldSystemFont(ofSize: 22)

        // write button
        writeButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        writeButton.tintColor = .black
        writeButton.addTarget(self, action: #selector(didTapWrite), for: .touchUpInside)

        categoryStackView.axis = .horizontal
        categoryStackView.spacing = 8

        categories.enumerated().forEach { index, title in
            let button = makeCategoryButton(title: title, isSelected: index == 0)
            button.tag = index
            button.addTarget(self, action: #selector(didTapCategory(_:)), for: .touchUpInside)
            categoryStackView.addArrangedSubview(button)
        }

        view.addSubview(titleLabel)
        view.addSubview(writeButton)
        view.addSubview(categoryStackView)
        view.addSubview(tableView)
    }
}

private extension CommunityViewController {

    func makeCategoryButton(title: String, isSelected: Bool) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 16
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)

        if isSelected {
            button.backgroundColor = UIColor(hex: "#4E74F9")
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = UIColor(hex: "#F2F2F2")
            button.setTitleColor(.gray, for: .normal)
        }

        return button
    }
}

extension CommunityViewController {

    private func setupLayout() {

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }

        writeButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.size.equalTo(24)
        }

        categoryStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(categoryStackView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
