//
//  MainCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit


enum TabFlow {
    case Feed
    case Search
    case Cart
    case Notifications
    case Profile
    //    case Login
}

protocol TabBaseCoordinator: Coordinator {

    var feedCoordinator: FeedBaseCoordinator { get }
    var searchCoordinator: SearchBaseCoordinator { get }
    var cartCoordinator: CartBaseCoordinator { get }
    var notificationsCoordinator: NotificationsBaseCoordinator { get }
    var profileCoordinator: ProfileBaseCoordinator { get }
    
    var deepLinkCoordinator: DeepLinkBaseCoordinator { get }
    func moveTo(flow: TabFlow)
}


class TabCoordinator: NSObject, TabBaseCoordinator {
    
    var parentCoordinator: TabBaseCoordinator?
    
    lazy var feedCoordinator: FeedBaseCoordinator = FeedCoordinator()
    lazy var searchCoordinator: SearchBaseCoordinator = SearchCoordinator()
    lazy var cartCoordinator: CartBaseCoordinator = CartCoordinator()
    lazy var notificationsCoordinator: NotificationsBaseCoordinator = NotificationsCoordinator()
    lazy var profileCoordinator: ProfileBaseCoordinator = ProfileCoordinator()
    
    lazy var deepLinkCoordinator: DeepLinkBaseCoordinator = DeepLinkCoordinator(mainBaseCoordinator: self)
    
    lazy var rootViewController: UIViewController = UITabBarController()
    

    func start() -> UIViewController {
        
        guard let tabBarController = rootViewController as? UITabBarController else {
            fatalError("proflem with tabbar")
        }
        
        tabBarController.tabBar.tintColor = K.Colors.darkGold
        tabBarController.tabBar.unselectedItemTintColor = K.Colors.gold
        tabBarController.tabBar.backgroundColor = .white
        
        tabBarController.delegate = self
        
        
        let feedViewController = feedCoordinator.start()
        feedCoordinator.parentCoordinator = self
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: K.Icons.houseFill, tag: 0)
        
        let searchViewController = searchCoordinator.start()
        searchCoordinator.parentCoordinator = self
        searchViewController.tabBarItem = UITabBarItem(title: "Поиск", image: K.Icons.magnifyingglassFill, tag: 1)
        
        let cartViewController = cartCoordinator.start()
        cartCoordinator.parentCoordinator = self
        cartViewController.tabBarItem = UITabBarItem(title: nil, image: K.Icons.cart.withRenderingMode(.alwaysOriginal), tag: 2)
        // TODO: move this one a little bit lower
        
        let notificationsViewController = notificationsCoordinator.start()
        notificationsCoordinator.parentCoordinator = self
        notificationsViewController.tabBarItem = UITabBarItem(title: "Уведомления", image: K.Icons.bellFill, tag: 3)
        
        let profileViewController = profileCoordinator.start()
        profileCoordinator.parentCoordinator = self
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: K.Icons.personFill, tag: 4)
        
        
        (rootViewController as? UITabBarController)?.viewControllers = [feedViewController, searchViewController, cartViewController, notificationsViewController, profileViewController]
        
        return rootViewController
    }
    
    // Mark 7
    func moveTo(flow: TabFlow) {
        switch flow {
        case .Feed:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .Search:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        case .Cart:
            (rootViewController as? UITabBarController)?.selectedIndex = 2
        case .Profile:
            (rootViewController as? UITabBarController)?.selectedIndex = 3
        case .Notifications:
            (rootViewController as? UITabBarController)?.selectedIndex = 4
        }
    }
    

    func handleDeepLink(text: String) {
        deepLinkCoordinator.handleDeeplink(deepLink: text)
    }
    

    func resetToRoot() -> Self {
        
        // TODO: think about it

        return self
    }
}



extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
//        profileCoordinator.resetToRoot()
        print("changed") // TODO: reset coordinator
//        vc.coordinator.resetToRoot()
//        guard let vc = viewController as? Coordinated else {
//            fatalError("problem with MainCoordinator's tabbar delegate")
//        }
//        vc.coordinator.parentCoordinator?.resetToRoot()
    }
}
