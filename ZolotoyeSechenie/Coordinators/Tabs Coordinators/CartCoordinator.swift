//
//  CartCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit
import Swinject

protocol CartCoordinatorDescription: Coordinator {
    //    @discardableResult func goToOrder2Screen(animated: Bool ) -> Self
    //    @discardableResult func goToOrder3Screen(animated: Bool) -> Self
}

class CartCoordinator: CartCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let cartVC = CartViewController()
        navigationController.pushViewController(cartVC, animated: true)
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
