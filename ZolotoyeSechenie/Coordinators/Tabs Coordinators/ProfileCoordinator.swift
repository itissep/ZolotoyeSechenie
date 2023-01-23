//
//  ProfileCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit


protocol ProfileBaseCoordinated: Coordinated {
    var coordinator: ProfileBaseCoordinator? { get }
}


protocol ProfileBaseCoordinator: Coordinator {
    func goToDeliveries()
    func goToFavourites()
    
    func goToAddresses()
    func goToChangeAddress()
    
    func goToPayment()
    
    func goToHistory()
    
    func deleteProfile()
    
    func signOut()
}


class ProfileCoordinator: ProfileBaseCoordinator {

    var parentCoordinator: MainBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: ProfileViewController(coordinator: self))
        return rootViewController
    }
    
    
    func goToDeliveries() {
        //
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
    
    func goToPayment() {
        //
    }
    
    func goToHistory() {
        //
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
