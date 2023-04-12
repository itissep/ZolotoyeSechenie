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
import Swinject

protocol AppCoordinatorDescription: Coordinator {
    func goToAuth()
    func goToHome()
    func childDidFinish(_ child: Coordinator)
}

class AppCoordinator: AppCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?
//    var userService: UserServiceDescription?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func goToAuth() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.container = container
        authCoordinator.parentCoordinator = self
        children.append(authCoordinator)
        authCoordinator.start()
    }

    func goToHome() {
        let coordinator = TabBarCoordinator(navigationController: navigationController)
        children.removeAll()
        coordinator.container = container
        coordinator.parentCoordinator = self
        coordinator.start()
    }

    func start() {
//        userService = container?.resolve(UserServiceDescription.self)
//        guard let userService else { return }

        if true { #warning("TODO: normal auth service")
            goToHome()
        } else {
            goToAuth()
        }
    }
}
