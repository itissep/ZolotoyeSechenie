////
////  TabCoordinator.swift
////  ZolotoyeSechenie
////
////  Created by Someone on 19.01.2023.
////
//
//import UIKit
//
//
//protocol TabCoordinatorProtocol: Coordinator {
//    var tabBarController: UITabBarController { get set }
//    
//    func selectPage(_ page: TabBarPage)
//    
//    func setSelectedIndex(_ index: Int)
//    
//    func currentPage() -> TabBarPage?
//}
//
//class TabCoordinator: NSObject, Coordinator {
//    weak var finishDelegate: CoordinatorFinishDelegate?
//        
//    var childCoordinators: [Coordinator] = []
//
//    var navigationController: UINavigationController
//    
//    var tabBarController: UITabBarController
//
//    var type: CoordinatorType { .tab }
//    
//    required init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
//        self.tabBarController = .init()
//    }
//
//    func start() {
//        // Let's define which pages do we want to add into tab bar
//        let pages: [TabBarPage] = [.feed, .search, .cart, .notifications, .profile]
//            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
//        
//        // Initialization of ViewControllers or these pages
//        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
//        
//        prepareTabBarController(withTabControllers: controllers)
//    }
//    
//    deinit {
//        print("TabCoordinator deinit")
//    }
//    
//    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
//        /// Set delegate for UITabBarController
//        tabBarController.delegate = self
//        /// Assign page's controllers
//        tabBarController.setViewControllers(tabControllers, animated: true)
//        /// Let set index
//        tabBarController.selectedIndex = TabBarPage.feed.pageOrderNumber()
//        /// Styling
////        tabBarController.tabBar.isTranslucent = false
//        
//        tabBarController.tabBar.tintColor = K.Colors.darkGold
//        tabBarController.tabBar.unselectedItemTintColor = K.Colors.gold
//        tabBarController.tabBar.backgroundColor = .white
//        
//        /// In this step, we attach tabBarController to navigation controller associated with this coordanator
//        navigationController.viewControllers = [tabBarController]
//    }
//      
//    private func getTabController(_ page: TabBarPage) -> UINavigationController {
//        let navController = UINavigationController()
//        navController.setNavigationBarHidden(false, animated: false)
//
//        let pageTitle: String?
//        let pageImage: UIImage
//        if page == .cart {
//            pageTitle = nil
//            pageImage = page.pageImage().withRenderingMode(.alwaysOriginal)
//        } else {
//            pageTitle = page.pageTitleValue()
//            pageImage = page.pageImage()
//        }
//        
//        navController.tabBarItem = UITabBarItem.init(title: pageTitle,
//                                                     image: pageImage,
//                                                     tag: page.pageOrderNumber())
//        
//        
//
//        switch page {
//            // If needed: Each tab bar flow can have it's own Coordinator.
//        case .feed:
//            let feedVC = FeedViewController()
//            navController.pushViewController(feedVC, animated: true)
//        case .search:
//            let searchVC = SearchViewController()
//            navController.pushViewController(searchVC, animated: true)
//        case .cart:
//            let cartVC = CartViewController()
//            
//            // FIXIT tabbar inserts
//            cartVC.tabBarItem.imageInsets = UIEdgeInsets(top: 60, left: 0, bottom: -60, right: 0)
//            
//            navController.pushViewController(cartVC, animated: true)
//        case .notifications:
//            let notifVC = NotificationsViewController()
//            navController.pushViewController(notifVC, animated: true)
//        case .profile:
//            let profileVC = ProfileViewController()
//            navController.pushViewController(profileVC, animated: true)
//        }
//        return navController
//    }
//    
//    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }
//
//    func selectPage(_ page: TabBarPage) {
//        tabBarController.selectedIndex = page.pageOrderNumber()
//    }
//    
//    func setSelectedIndex(_ index: Int) {
//        guard let page = TabBarPage.init(index: index) else { return }
//        
//        tabBarController.selectedIndex = page.pageOrderNumber()
//    }
//}
//
//// MARK: - UITabBarControllerDelegate
//extension TabCoordinator: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController,
//                          didSelect viewController: UIViewController) {
//        // Some implementation
//    }
//    
//}
