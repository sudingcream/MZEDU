import UIKit
import SnapKit

final class TeacherRegisterBannerView: UIView {

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let avatarView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func configureUI() {
        backgroundColor = UIColor(hex: "#2F5BEA")
        layer.cornerRadius = 16

        titleLabel.text = "선생님이세요?"
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white

        subtitleLabel.text = "선생님 목록에 등록하고 학생을 만나보세요!"
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .white

        avatarView.image = UIImage(named: "teacherIcon")
        avatarView.tintColor = .white
        avatarView.contentMode = .scaleAspectFit

        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(avatarView)
    }

    private func setupLayout() {

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }

        avatarView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(40)
        }
    }
}
