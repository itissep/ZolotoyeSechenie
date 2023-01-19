//
//  AppCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//

import Foundation
import UIKit
//import FirebaseFirestore
//import FirebaseAuth

final class AppCoordinator: Coordinator{
    
    private let window: UIWindow
    
//    let dependencies: AppDependencies
    
    var childCoordinators: [Coordinator]
    
    var rootViewController: UINavigationController
    
    init(window: UIWindow){
        self.window = window
//        dependencies = AppDependencies(firestore: Firestore)
        childCoordinators = []
        rootViewController = UINavigationController.createDefault()
        
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        showTabBarController()
    }
    
    private func showTabBarController(){
        let tabBarCoordinator = TabBarCoordinator(rootViewController: rootViewController)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
        

        
    }
    

    
}
