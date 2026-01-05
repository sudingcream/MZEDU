import UIKit
import SnapKit

final class CommunityPostCell: UITableViewCell {

    private let containerView = UIView()
    private let typeLabel = UILabel()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let timeLabel = UILabel()
    private let likeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(type: String, title: String, content: String, time: String, likeCount: Int) {
        typeLabel.text = type
        titleLabel.text = title
        contentLabel.text = content
        timeLabel.text = time
        likeLabel.text = "♡ \(likeCount)"
    }

    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.05
        containerView.layer.shadowRadius = 6

        typeLabel.font = .systemFont(ofSize: 12, weight: .medium)
        typeLabel.textColor = UIColor(hex: "#4E74F9")

        titleLabel.font = .boldSystemFont(ofSize: 15)

        contentLabel.font = .systemFont(ofSize: 13)
        contentLabel.textColor = .gray
        contentLabel.numberOfLines = 2

        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .lightGray

        likeLabel.font = .systemFont(ofSize: 12)

        contentView.addSubview(containerView)
        [typeLabel, titleLabel, contentLabel, timeLabel, likeLabel].forEach {
            containerView.addSubview($0)
        }
    }

    private func setupLayout() {

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(100)
        }

        typeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.bottom.equalToSuperview().inset(16)
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        likeLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().offset(16)
        }

        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(likeLabel)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
