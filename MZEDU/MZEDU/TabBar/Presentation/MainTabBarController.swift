import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }

    private func setupTabs() {

        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(named: "home_off")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(named: "home_on")?.withRenderingMode(.alwaysTemplate)
        )

        let communityVC = CommunityViewController()
        communityVC.tabBarItem = UITabBarItem(
            title: "커뮤니티",
            image: UIImage(named: "community_off")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(named: "community_on")?.withRenderingMode(.alwaysTemplate)
        )

        let lessonVC = LessonViewController()
        lessonVC.tabBarItem = UITabBarItem(
            title: "과외찾기",
            image: UIImage(named: "lesson_off")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(named: "lesson_on")?.withRenderingMode(.alwaysTemplate)
        )

        let myVC = MyViewController()
        myVC.tabBarItem = UITabBarItem(
            title: "MY",
            image: UIImage(named: "user_off")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(named: "user_on")?.withRenderingMode(.alwaysTemplate)
        )

        viewControllers = [homeVC, communityVC, lessonVC, myVC]
    }

    private func setupAppearance() {

        let selectedColor = UIColor(hex: "#4E74F9")
        let unselectedColor = UIColor(hex: "#9199A6")

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: selectedColor
        ]

        appearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: unselectedColor
        ]

        tabBar.standardAppearance = appearance

        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
