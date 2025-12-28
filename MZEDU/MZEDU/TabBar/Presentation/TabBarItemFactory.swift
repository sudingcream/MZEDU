import UIKit

enum TabType {
    case home
    case community
    case my

    var title: String {
        switch self {
        case .home: return "홈"
        case .community: return "커뮤니티"
        case .my: return "MY"
        }
    }

    var selectedImageName: String {
        switch self {
        case .home: return "home_on"
        case .community: return "community_on"
        case .my: return "user_on"
        }
    }

    var unselectedImageName: String {
        switch self {
        case .home: return "home_off"
        case .community: return "community_off"
        case .my: return "user_off"
        }
    }
}

struct TabBarItemFactory {

    static func makeTabBarItem(type: TabType) -> UITabBarItem {
        let selectedImage = UIImage(named: type.selectedImageName)?
            .withRenderingMode(.alwaysOriginal)
        let unselectedImage = UIImage(named: type.unselectedImageName)?
            .withRenderingMode(.alwaysOriginal)

        let item = UITabBarItem(
            title: type.title,
            image: unselectedImage,
            selectedImage: selectedImage
        )

        return item
    }
}
