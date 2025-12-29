import UIKit
import SnapKit

final class LessonViewController: UIViewController {

    private let screenTitleLabel = UILabel()
    private let headerLabel = UILabel()
    private let tableView = UITableView()
    private let teacherBannerView = TeacherRegisterBannerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
        setupTableView()
    }
}

// MARK: - UI
extension LessonViewController {

    private func configureUI() {
        view.backgroundColor = UIColor(hex: "#F7F8FA")
 
        navigationItem.title = ""

        screenTitleLabel.text = "과외 선생님 찾기"
        screenTitleLabel.font = .boldSystemFont(ofSize: 22)
        screenTitleLabel.textColor = .black

        headerLabel.text = "현재 활동중인 선생님 814명"
        headerLabel.font = .systemFont(ofSize: 15, weight: .medium)
        headerLabel.textColor = .darkGray

        view.addSubview(screenTitleLabel)
        view.addSubview(headerLabel)
        view.addSubview(tableView)
        view.addSubview(teacherBannerView)
    }
}

// MARK: - Layout
extension LessonViewController {

    private func setupLayout() {

        screenTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }

        headerLabel.snp.makeConstraints {
            $0.top.equalTo(screenTitleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(teacherBannerView.snp.top).offset(-12)
        }

        teacherBannerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.height.equalTo(72)
        }
    }
}

// MARK: - TableView
extension LessonViewController: UITableViewDelegate, UITableViewDataSource {

    private func setupTableView() {
        tableView.register(TeacherCell.self, forCellReuseIdentifier: "TeacherCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "TeacherCell",
            for: indexPath
        ) as? TeacherCell else {
            return UITableViewCell()
        }

        cell.configure(
            name: indexPath.row == 1 ? "이지연 선생님" : "김지훈 선생님",
            university: indexPath.row == 1 ? "연세대학교 영어영문학" : "서울대학교 수리과학부",
            intro: "“수학은 단순 암기가 아닙니다. 원리부터 심화까지, 상위 1%로 가는 길을 함께하겠습니다”"
        )

        return cell
    }
}
extension LessonViewController {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let detailVC = TeacherDetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
        
    }
}
