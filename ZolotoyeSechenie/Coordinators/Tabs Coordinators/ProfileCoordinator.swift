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
    func goToAddress(_ type: EditAddressType)
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
    var addressService: AddressServiceDescription?
    
    var coreDataManager: CoreDataManagerDescrption?
    var coreDataCombine: CoreDataStoring?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        userService = container?.resolve(UserServiceDescription.self)
        orderService = container?.resolve(OrderServiceDescription.self)
        addressService = container?.resolve(AddressServiceDescription.self)
        coreDataManager = container?.resolve(CoreDataManagerDescrption.self)
        coreDataCombine = container?.resolve(CoreDataStoring.self)
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
        #warning("TODO: add userId")
        let viewModel = ProfileViewModel(userId: "", userService: userService, orderService: orderService, coordinator: self)
        let profileVC = ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(profileVC, animated: true)
    }
    
    func goToAllAddresses() {
        guard let addressService, let coreDataManager, let coreDataCombine else { return }
        let viewModel = AddressesViewModel(userId: "", addressService: addressService, coreDataManager: coreDataCombine, coordinator: self)
        let addressesVc = AddressesViewController(viewModel: viewModel)
        navigationController.pushViewController(addressesVc, animated: true)
    }
    
    func goToAddress(_ type: EditAddressType) {
        guard let addressService else { return }
        let viewModel = EditAddressViewModel(userId: "", type: type, addressService: addressService, coordinator: self)
        let editAddressVC = EditAddressViewController(viewModel: viewModel)
        navigationController.pushViewController(editAddressVC, animated: true)
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
