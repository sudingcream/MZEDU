import UIKit
import SnapKit

final class TeacherDetailViewController: UIViewController {

    // MARK: - Scroll
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // MARK: - Header
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    // MARK: - Info
    private let infoStackView = UIStackView()
    private let nameField = UILabel()
    private let universityField = UILabel()
    private let majorField = UILabel()
    private let studentIdField = UILabel()

    // MARK: - Certificate
    private let certificateTitleLabel = UILabel()

    private let uploadBoxView = UIView()
    private let uploadIconImageView = UIImageView()
    private let uploadLabel = UILabel()
    private let uploadCertificateLabel = UILabel()

    private let fileInfoView = UIView()
    private let fileNameLabel = UILabel()
    private let removeFileButton = UIButton(type: .system)

    // MARK: - Privacy
    private let infoBoxView = UIView()
    private let shieldIconImageView = UIImageView()
    private let infoLabel = UILabel()

    // MARK: - Bottom Buttons
    private let bottomStackView = UIStackView()
    private let prevButton = UIButton(type: .system)
    private let submitButton = UIButton(type: .system)

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addDashedBorder(to: uploadBoxView)
    }
}

// MARK: - UI
extension TeacherDetailViewController {

    private func configureUI() {
        view.backgroundColor = .white
        title = "선생님 등록하기"

        // Scroll
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Header
        titleLabel.text = "학생들에게 신뢰를 줄 수 있는\n학력 정보를 입력해주세요."
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0

        descriptionLabel.text = "제출하신 서류는 운영진 확인 후 즉시 비공개 처리됩니다."
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray

        // Info stack
        infoStackView.axis = .vertical
        infoStackView.spacing = 24

        nameField.text = "본인 이름\n김에듀"
        universityField.text = "대학교\nMZ EDU 대학교"
        majorField.text = "졸업/재학 학과\nMZ EDU 학과"
        studentIdField.text = "학번\n20260000"

        [nameField, universityField, majorField, studentIdField].forEach {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textColor = .lightGray   // placeholder 느낌
            infoStackView.addArrangedSubview($0)
        }

        // Certificate title
        certificateTitleLabel.text = "학력증명서"
        certificateTitleLabel.font = .boldSystemFont(ofSize: 16)

        // Upload box
        uploadBoxView.layer.cornerRadius = 12
        uploadBoxView.backgroundColor = .clear

        uploadIconImageView.image = UIImage(systemName: "arrow.up")
        uploadIconImageView.tintColor = .gray
        uploadIconImageView.backgroundColor = UIColor(hex: "#F2F2F2")
        uploadIconImageView.layer.cornerRadius = 20
        uploadIconImageView.clipsToBounds = true

        uploadLabel.text = "증명서 사진 업로드"
        uploadLabel.font = .systemFont(ofSize: 15, weight: .medium)
        uploadLabel.textAlignment = .center

        uploadCertificateLabel.text = "졸업/재학증명서 또는 학생증 (JPG, PNG)"
        uploadCertificateLabel.font = .systemFont(ofSize: 13)
        uploadCertificateLabel.textColor = .gray
        uploadCertificateLabel.textAlignment = .center
        uploadCertificateLabel.numberOfLines = 0

        // File info
        fileInfoView.backgroundColor = UIColor(hex: "#F5F6F8")
        fileInfoView.layer.cornerRadius = 10

        fileNameLabel.text = "graduate_proof_2024.jpg"
        fileNameLabel.font = .systemFont(ofSize: 14)

        removeFileButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        removeFileButton.tintColor = .gray

        // Info box
        infoBoxView.backgroundColor = UIColor(hex: "#EEF3FF")
        infoBoxView.layer.cornerRadius = 12

        shieldIconImageView.image = UIImage(systemName: "checkmark.shield.fill")
        shieldIconImageView.tintColor = UIColor(hex: "#4E74F9")

        infoLabel.text =
        "에듀커넥트는 선생님의 개인정보를 최우선으로 보호합니다.\n제출하신 서류는 본인 확인 용도로만 사용되며, 인증 완료 후 즉시 파기되거나 암호화 저장됩니다."
        infoLabel.font = .systemFont(ofSize: 13)
        infoLabel.numberOfLines = 0
        infoLabel.textColor = UIColor(hex: "#4E74F9")

        // Bottom buttons
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 12

        prevButton.setTitle("이전", for: .normal)
        prevButton.backgroundColor = UIColor(hex: "#F2F2F2")
        prevButton.layer.cornerRadius = 24

        submitButton.setTitle("인증 요청하기", for: .normal)
        submitButton.backgroundColor = UIColor(hex: "#4E74F9")
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 24

        // Add hierarchy
        view.addSubview(bottomStackView)

        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(infoStackView)
        contentView.addSubview(certificateTitleLabel)
        contentView.addSubview(uploadBoxView)
        contentView.addSubview(fileInfoView)
        contentView.addSubview(infoBoxView)

        uploadBoxView.addSubview(uploadIconImageView)
        uploadBoxView.addSubview(uploadLabel)
        uploadBoxView.addSubview(uploadCertificateLabel)

        fileInfoView.addSubview(fileNameLabel)
        fileInfoView.addSubview(removeFileButton)

        infoBoxView.addSubview(shieldIconImageView)
        infoBoxView.addSubview(infoLabel)

        bottomStackView.addArrangedSubview(prevButton)
        bottomStackView.addArrangedSubview(submitButton)
    }
}

// MARK: - Layout
extension TeacherDetailViewController {

    private func setupLayout() {

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(titleLabel)
        }

        infoStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        certificateTitleLabel.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(20)
        }

        uploadBoxView.snp.makeConstraints {
            $0.top.equalTo(certificateTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(140)
        }

        uploadIconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }

        uploadLabel.snp.makeConstraints {
            $0.top.equalTo(uploadIconImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        uploadCertificateLabel.snp.makeConstraints {
            $0.top.equalTo(uploadLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        fileInfoView.snp.makeConstraints {
            $0.top.equalTo(uploadBoxView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(uploadBoxView)
            $0.height.equalTo(48)
        }

        fileNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }

        removeFileButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
        }

        infoBoxView.snp.makeConstraints {
            $0.top.equalTo(fileInfoView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-100)
        }

        shieldIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(16)
            $0.size.equalTo(24)
        }

        infoLabel.snp.makeConstraints {
            $0.leading.equalTo(shieldIconImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.bottom.equalToSuperview().inset(16)
        }

        bottomStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(52)
        }

        prevButton.snp.makeConstraints {
            $0.width.equalTo(100)
        }
    }
}

// MARK: - Dashed Border
extension TeacherDetailViewController {

    private func addDashedBorder(to view: UIView) {
        view.layer.sublayers?.removeAll(where: { $0 is CAShapeLayer })

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [6, 4]
        shapeLayer.path = UIBezierPath(
            roundedRect: view.bounds,
            cornerRadius: 12
        ).cgPath

        view.layer.addSublayer(shapeLayer)
    }
}
