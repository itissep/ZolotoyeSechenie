//
//  SearchCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit
import Swinject


//protocol SearchBaseCoordinated: Coordinated {
//    var coordinator: SearchBaseCoordinator? { get }
//}

protocol SearchCoordinatorDescription: Coordinator {
    //    @discardableResult func goToOrder2Screen(animated: Bool ) -> Self
    //    @discardableResult func goToOrder3Screen(animated: Bool) -> Self
}

class SearchCoordinator: SearchCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {

        goToSearch()
    }
    
    func goToSearch() {
        let searchVC = SearchViewController()
        navigationController.pushViewController(searchVC, animated: true)
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
