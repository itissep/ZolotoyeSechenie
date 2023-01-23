////
////  AppCoordinator.swift
////  ZolotoyeSechenie
////
////  Created by Someone on 19.01.2023.
////
//
//
//
import UIKit


protocol AppBaseCoordinator: Coordinator {
    
    var tabbarCoordinator: TabBaseCoordinator { get }
//    var loginCoordinator:
    func showLoginFlow()
    func showMainFlow()
}


class AppCoordinator: NSObject, AppBaseCoordinator {
//    var parentCoordinator: AppBaseCoordinator?
    
    var isAuth = false // TODO: move to di container
    
    var tabbarCoordinator: TabBaseCoordinator = TabCoordinator()
    
    var parentCoordinator: TabBaseCoordinator?
    
    lazy var feedCoordinator: FeedBaseCoordinator = FeedCoordinator()
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        if isAuth {
            
        } else {
            let searchViewController = tabbarCoordinator.start()
            rootViewController = UINavigationController(rootViewController: searchViewController)
            return rootViewController
        }
        
        return UIViewController()
    }
    
        func showLoginFlow() {
            //
        }
        
        func showMainFlow() {
            //
        }
    
}
