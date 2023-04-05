//
//  TabBarCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import UIKit
import Swinject

class TabBarCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("HomeTabbar Coordinator Deinit")
    }

    func start() {
        print("HomeTabbar Coordinator Init")
        setupTabBar()
    }

    func setupTabBar() {
        let tabBarController = UITabBarController()
        var controllers: [UINavigationController] = []

        for tab in Tab.allCases {
            let homeNavigationController = UINavigationController()
            homeNavigationController.tabBarItem = tab.getTabBarItem()
            controllers.append(homeNavigationController)

            let tabCoordinator = tab.getCoordinator(navigationController: homeNavigationController)

            tabCoordinator.container = container
            parentCoordinator?.children.append(tabCoordinator)
            tabCoordinator.start()
        }

        tabBarController.tabBar.tintColor = K.Colors.darkGold
        tabBarController.tabBar.unselectedItemTintColor = K.Colors.gold
        tabBarController.tabBar.backgroundColor = .white
        
        tabBarController.viewControllers = controllers
        navigationController.pushViewController(tabBarController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)

    }

}

enum Tab: CaseIterable {
    case feed, search, cart, notifications, profile

    func getTabBarItem() -> UITabBarItem {
        let tabBarItem = UITabBarItem()
        switch self {
        case .feed:
            tabBarItem.title = "Главная"
            tabBarItem.image = K.Icons.houseFill
        case .search:
            tabBarItem.title = "Поиск"
            tabBarItem.image = K.Icons.magnifyingglassFill
        case .profile:
            tabBarItem.title = "Профиль"
            tabBarItem.image = K.Icons.personFill
        case .cart:
            tabBarItem.title = nil
            tabBarItem.image = K.Icons.cart.withRenderingMode(.alwaysOriginal)
        case .notifications:
            tabBarItem.title = "Уведомления"
            tabBarItem.image = K.Icons.bellFill
        }
        return tabBarItem
    }

    func getCoordinator(navigationController: UINavigationController) -> Coordinator {
        switch self {
        case .feed:
            return FeedCoordinator(navigationController: navigationController)
        case .profile:
            return ProfileCoordinator(navigationController: navigationController)
        case .search:
            return SearchCoordinator(navigationController: navigationController)
        case .cart:
            return CartCoordinator(navigationController: navigationController)
        case .notifications:
            return NotificationsCoordinator(navigationController: navigationController)
        }
    }
}
