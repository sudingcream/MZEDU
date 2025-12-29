import UIKit
import SnapKit

final class TeacherCell: UITableViewCell {

    private let containerView = UIView()
    private let nameLabel = UILabel()
    private let universityLabel = UILabel()
    private let introLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(name: String, university: String, intro: String) {
        nameLabel.text = name
        universityLabel.text = university
        introLabel.text = intro
    }

    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.layer.shadowOpacity = 0.05
        containerView.layer.shadowRadius = 6

        nameLabel.font = .boldSystemFont(ofSize: 17)

        universityLabel.font = .systemFont(ofSize: 14, weight: .medium)
        universityLabel.textColor = UIColor(hex: "#4E74F9")

        introLabel.font = .systemFont(ofSize: 14)
        introLabel.textColor = .gray
        introLabel.numberOfLines = 0

        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(universityLabel)
        containerView.addSubview(introLabel)
    }

    private func setupLayout() {

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }

        universityLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(nameLabel)
        }

        introLabel.snp.makeConstraints {
            $0.top.equalTo(universityLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
}
