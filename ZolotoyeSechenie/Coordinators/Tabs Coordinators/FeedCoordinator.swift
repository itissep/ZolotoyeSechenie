//
//  FeedCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit
import Swinject

protocol FeedCoordinatorDescription: Coordinator {
    func goToCollection(type: CollectionType)
    func goToProduct(id: String)
    
    //    @discardableResult func goToOrder2Screen(animated: Bool ) -> Self
    //    @discardableResult func goToOrder3Screen(animated: Bool) -> Self
}

class FeedCoordinator: FeedCoordinatorDescription {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?
    
    var productService: ProductServiceDescription?
    var imageService: ImageServiceDescription?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(){
        productService = container?.resolve(ProductServiceDescription.self)
        imageService = container?.resolve(ImageServiceDescription.self)
        
        goToFeedScreen()
    }
    
    func goToFeedScreen() {
        guard let productService else { return }
        
        let viewModel = FeedViewModel(productService: productService, coordinator: self)
        let homeVC = FeedViewController(viewModel: viewModel)
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func goToCollection(type: CollectionType) {
        let vc = ProductsViewController(type: type)
        navigationController.pushViewController(vc, animated: true)
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
