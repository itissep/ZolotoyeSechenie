//
//  ProfileCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit

enum OrdersType {
    case deliveries, history
}

protocol ProfileBaseCoordinated: Coordinated {
    var coordinator: ProfileBaseCoordinator? { get }
}


protocol ProfileBaseCoordinator: Coordinator {
    func goToDeliveries()
    func goToFavourites()
    
    func goToAddresses()
    func goToChangeAddress()
    
//    func goToPayment()
    
    func goToHistory()
    
    func deleteProfile()
    
    func signOut()
}


class ProfileCoordinator: ProfileBaseCoordinator {

    var parentCoordinator: TabBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: ProfileViewController(coordinator: self))
        return rootViewController
    }
    
    
    func goToDeliveries() {
        let deliveriesViewController = OrdersViewController(coordinator: self, type: .deliveries)
        navigationRootViewController?.pushViewController(deliveriesViewController, animated: true)
    }
    
    func goToFavourites() {
        //
    }
    
    func goToAddresses() {
        let addressesViewController = AddressesViewController(coordinator: self)
        navigationRootViewController?.pushViewController(addressesViewController, animated: true)
    }
    
    func goToChangeAddress() {
        //
        
    }

    
    func goToHistory() {
        let historyViewController = OrdersViewController(coordinator: self, type: .history)
        navigationRootViewController?.pushViewController(historyViewController, animated: true)
    }
    
    func deleteProfile() {
        //
    }
    
    func signOut() {
        //
    }
    
    
    //    func goToDeepViewInFavoriteTab() {
    //        parentCoordinator?.moveTo(flow: .Feed)
    //        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) { [weak self] in
    //            self?.parentCoordinator?.ordersCoordinator
    //                .resetToRoot()
    ////                .goToOrder2Screen(animated: false)
    ////                .goToOrder3Screen(animated: false)
    //        }
    //    }
}
