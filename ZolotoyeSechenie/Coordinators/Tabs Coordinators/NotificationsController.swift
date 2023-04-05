//
//  NotificationsController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit
import Swinject

protocol NotificationsCoordinatorDescription: Coordinator {
    //    @discardableResult func goToOrder2Screen(animated: Bool ) -> Self
    //    @discardableResult func goToOrder3Screen(animated: Bool) -> Self
}


class NotificationsCoordinator: NotificationsCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?

//    var userService: UserServiceDescription?
//    var imageService: ImageServiceDescription?
//    var userDefaultsService: UserDefaultsService?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    
    func start() {
        goToNotifications()
    }
    
    func goToNotifications() {
        let notificationsVC = NotificationsViewController()
        navigationController.pushViewController(notificationsVC, animated: true)
    }
    
    //    func goToOrder2Screen(animated: Bool = false) -> Self {
    //        navigationRootViewController?.pushViewController(Orders2ViewController(coordinator: self), animated: animated)
    //        return self
    //    }
    //
    //    func goToOrder3Screen(animated: Bool = false) -> Self {
    //        navigationRootViewController?.pushViewController(Orders3ViewController(coordinator: self), animated: animated)
    //        return self
    //    }
}
