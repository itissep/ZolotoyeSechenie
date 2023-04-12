//
//  OrderCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 12.04.2023.
//

import UIKit
import Swinject

protocol OrderCoordinatorDescription: Coordinator {
    func goToDelieveryDetailsScreen()
    func goToCourierDetailsScreen()
    func goToAddNewAddress()
    func goToPaymentMethodPicker()
}

class OrderCoordinator: OrderCoordinatorDescription {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    var container: Container?
    
    var addressService: AddressServiceDescription?
    #warning("TODO: add paymentManager")
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(){
        addressService = container?.resolve(AddressServiceDescription.self)
        
        goToDelieveryDetailsScreen()
    }
    
    func goToDelieveryDetailsScreen() {
        let viewModel = DelieveryDetailsViewModel()
        let delieveryDetailsVC = DelieveryDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(delieveryDetailsVC, animated: true)
    }
    
    func goToCourierDetailsScreen() {
        //
    }
    
    func goToAddNewAddress() {
        //
    }
    
    func goToPaymentMethodPicker() {
        //
    }
    
}

