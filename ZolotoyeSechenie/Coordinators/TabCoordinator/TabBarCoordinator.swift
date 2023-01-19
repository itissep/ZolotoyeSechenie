//
//  TabBarCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//

import Foundation
import UIKit
//import FirebaseAuth

//final class TabBarCoordinator: Coordinator{
//    var rootViewController: UINavigationController
//
//    var rootTabBarController: UITabBarController
//
//    var childCoordinators: [Coordinator]
//
//    init(rootViewController: UINavigationController){
//
//        self.rootViewController = rootViewController
//        childCoordinators = []
//
//
//        rootTabBarController = UITabBarController()
//
//        let seacrhVC = SearchViewController()
//        seacrhVC.tabBarItem.image = UIImage(systemName: "trash")
//        seacrhVC.tabBarItem.title = "Поиск"
//
//        let feedVC = FeedViewController()
//        feedVC.tabBarItem.image = UIImage(systemName: "pencil")
//        feedVC.tabBarItem.title = "Лента"
//
//
//        let cartVC = CartViewController()
//        cartVC.tabBarItem.title = "Корзина"
//
//        cartVC.tabBarItem = UITabBarItem(title: nil,
//                                         image: UIImage(systemName: "archivebox")?.withRenderingMode(.alwaysOriginal),
//                                                tag: 0)
//        cartVC.tabBarItem.imageInsets = UIEdgeInsets(top: 7,
//                                                            left: 0,
//                                                            bottom: -7,
//                                                            right: 0)
//
//
//        let notificationVC = NotificationsViewController()
//        notificationVC.tabBarItem.image = UIImage(systemName: "folder")
//        notificationVC.tabBarItem.title = "Уведомления"
//
//
//
//        let provileVC = ProfileViewController()
//        provileVC.tabBarItem.image = UIImage(systemName: "paperplane")
//        provileVC.tabBarItem.title = "Профиль"
//
//
//
//        let controllers = [feedVC, seacrhVC, cartVC, notificationVC, provileVC]
//
//        rootTabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
//        rootTabBarController.tabBar.tintColor = .red
//        rootTabBarController.tabBar.unselectedItemTintColor = .green
//
//
//        rootTabBarController.tabBar.backgroundColor = .white
//
////        NotificationCenter.default.addObserver(self, selector: #selector(setLoginViewControllers), name: NSNotification.Name("InterestViewController.signUp.succes.ArtDeFond"), object: nil)
////
////        NotificationCenter.default.addObserver(self, selector: #selector(goToFeedTab), name: NSNotification.Name("CostViewModel.uploadPicture.success.ArtDeFond"), object: nil)
//    }
//
//    func start() {
//        rootViewController.pushViewController(rootTabBarController, animated: true)
//    }
//
//    @objc
//      func goToFeedTab(){
//          rootTabBarController.selectedIndex = 0
//      }
//
//
////    @objc
////    func setLoginViewControllers(){
////        let seacrhVC = SearchViewController()
////        seacrhVC.tabBarItem.image = Constants.Icons.search
////        seacrhVC.tabBarItem.title = "Поиск"
////
////        let feedVC = FeedViewController(viewModel: FeedViewModel())
////        feedVC.tabBarItem.image = Constants.Icons.house
////        feedVC.tabBarItem.title = "Лента"
////
////        let uploadPhotoVC = UploadPhotoViewController(viewModel: .init())
////
////        uploadPhotoVC.tabBarItem = UITabBarItem(title: nil,
////                                              image: Constants.Icons.bigPlus.withRenderingMode(.alwaysOriginal),
////                                              tag: 0)
////        uploadPhotoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 7,
////                                                          left: 0,
////                                                          bottom: -7,
////                                                          right: 0)
////
////        let notificationVC = NotificationsViewController(viewModel: NotificationsViewModel())
////        notificationVC.tabBarItem.image = Constants.Icons.bell
////        notificationVC.tabBarItem.title = "Уведомления"
////
////        let provileVC = ProfileViewController(viewModel: ProfileViewModel())
////        provileVC.tabBarItem.image = Constants.Icons.profile
////        provileVC.tabBarItem.title = "Профиль"
////
////        let controllers = [feedVC, seacrhVC, uploadPhotoVC, notificationVC, provileVC]
////
////        rootTabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
////    }
//}
//
////extension TabBarCoordinator: AuthViewContollerDelegate{
////    func DidLogin() {
////        let seacrhVC = SearchViewController()
////        seacrhVC.tabBarItem.image = Constants.Icons.search
////        seacrhVC.tabBarItem.title = "Поиск"
////
////        let feedVC = FeedViewController(viewModel: FeedViewModel())
////        feedVC.tabBarItem.image = Constants.Icons.house
////        feedVC.tabBarItem.title = "Лента"
////
////        let uploadPhotoVC = UploadPhotoViewController(viewModel: .init())
////
////        uploadPhotoVC.tabBarItem = UITabBarItem(title: nil,
////                                              image: Constants.Icons.bigPlus.withRenderingMode(.alwaysOriginal),
////                                              tag: 0)
////        uploadPhotoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 7,
////                                                          left: 0,
////                                                          bottom: -7,
////                                                          right: 0)
////
////        let notificationVC = NotificationsViewController(viewModel: NotificationsViewModel())
////        notificationVC.tabBarItem.image = Constants.Icons.bell
////        notificationVC.tabBarItem.title = "Уведомления"
////
////        let provileVC = ProfileViewController(viewModel: ProfileViewModel())
////        provileVC.tabBarItem.image = Constants.Icons.profile
////        provileVC.tabBarItem.title = "Профиль"
////
////        let controllers = [feedVC, seacrhVC, uploadPhotoVC, notificationVC, provileVC]
////
////        rootTabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
////    }
////
////
////}
