//
//  SearchCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit


protocol SearchBaseCoordinated: Coordinated {
    var coordinator: SearchBaseCoordinator? { get }
}

protocol SearchBaseCoordinator: Coordinator {
    //    @discardableResult func goToOrder2Screen(animated: Bool ) -> Self
    //    @discardableResult func goToOrder3Screen(animated: Bool) -> Self
}

class SearchCoordinator: SearchBaseCoordinator {
    
    var parentCoordinator: TabBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: SearchViewController(coordinator: self))
        return rootViewController
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
