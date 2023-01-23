//
//  FeedCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit


protocol FeedBaseCoordinated: Coordinated {
    var coordinator: FeedBaseCoordinator? { get }
}

protocol FeedBaseCoordinator: Coordinator {
    func goToCollection(type: CollectionType)
    func goToProduct(id: String)
    
    //    @discardableResult func goToOrder2Screen(animated: Bool ) -> Self
    //    @discardableResult func goToOrder3Screen(animated: Bool) -> Self
}

class FeedCoordinator: FeedBaseCoordinator {
    
    var parentCoordinator: TabBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: FeedViewController(coordinator: self))
        return rootViewController
    }
    
    func goToCollection(type: CollectionType) {
        let vc = ProductsViewController(coordinator: self, type: type)
        navigationRootViewController?.pushViewController(vc, animated: true)
    }
    
    func goToProduct(id: String) {
        //
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
