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
    func goToCourierDetailsScreen(with city: String)
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
        let viewModel = DelieveryDetailsViewModel(coordinator: self)
        let delieveryDetailsVC = DelieveryDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(delieveryDetailsVC, animated: true)
    }
    
    func goToCourierDetailsScreen(with city: String) {
        guard let addressService else { return }
        let viewModel = CourierDetailsViewModel(addressService: addressService, coordinator: self)
        let courierDetailsVC = CourierDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(courierDetailsVC, animated: true)
    }
    
    func goToAddNewAddress() {
        //
    }
    
    func goToPaymentMethodPicker() {
        let viewModel = OrderPaymentMethodViewModel(coordinator: self)
        let orderPaymentMethodVC = OrderPaymentMethodViewController(viewModel: viewModel)
        navigationController.pushViewController(orderPaymentMethodVC, animated: true)
    }
    
}

