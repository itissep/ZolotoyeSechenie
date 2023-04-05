//
//  ProfileCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import UIKit
import Swinject

protocol ProfileCoordinatorDescription: Coordinator {
    func goToProfile()
//    func goToEditProfileScreen(with userId: String)
    func goToSignIn()
    func goToAllAddresses()
    func goToAddress(with addressId: String)
    func goToHistory()
    func goToDeliveries()
    func goToFavourites()
}

class ProfileCoordinator: ProfileCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?

    var userService: UserServiceDescription?
    var userDefaultsService: UserDefaultsService?
    var orderService: OrderServiceDescription?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        userService = container?.resolve(UserServiceDescription.self)
        orderService = container?.resolve(OrderServiceDescription.self)
//        userDefaultsService = container?.resolve(UserDefaultsService.self)

        goToProfile()
    }

    func goToProfile() {
        guard
//            let userDefaultsService,
            let userService,
            let orderService
//            let userId = userDefaultsService.getString(with: .userId)
        else {
            return
        }
        let viewModel = ProfileViewModel(userId: "", userService: userService, orderService: orderService, coordinator: self)
        let profileVC = ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(profileVC, animated: true)
    }
    
    func goToAllAddresses() {
        //
    }
    
    func goToAddress(with addressId: String) {
        //
    }
    
    func goToHistory() {
        //
    }

    func goToSignIn() {

    }
    
    func goToDeliveries() {
        //
    }
    
    func goToFavourites() {
        //
    }
}
