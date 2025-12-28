import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }

    private func setupTabs() {
        let homeVC = HomeViewController()
        homeVC.view.backgroundColor = .white
        homeVC.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(named: "home_off"),
            selectedImage: UIImage(named: "home_on")
        )

        let communityVC = CommunityViewController()
        communityVC.view.backgroundColor = .white
        communityVC.tabBarItem = UITabBarItem(
            title: "커뮤니티",
            image: UIImage(named: "community_off"),
            selectedImage: UIImage(named: "community_on")
        )

        let myVC = MyViewController()
        myVC.view.backgroundColor = .white
        myVC.tabBarItem = UITabBarItem(
            title: "MY",
            image: UIImage(named: "user_off"),
            selectedImage: UIImage(named: "user_on")
        )

        viewControllers = [homeVC, communityVC, myVC]
    }
    private func setupAppearance() {
        let selectedColor = UIColor(hex: "#4E74F9")
        let unselectedColor = UIColor(hex: "#9199A6")

        tabBar.tintColor = selectedColor
        tabBar.unselectedItemTintColor = unselectedColor
        tabBar.backgroundColor = .white

        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: selectedColor
        ]

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: unselectedColor
        ]

        tabBar.items?.forEach { item in
            item.setTitleTextAttributes(normalAttributes, for: .normal)
            item.setTitleTextAttributes(selectedAttributes, for: .selected)
        }
    }

}
