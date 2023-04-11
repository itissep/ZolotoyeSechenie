//
//  AppDelegate.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 08.11.2022.
//

import UIKit
import CoreData
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let container = Container()

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        registerMockDependencies()

        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.container = container
        appCoordinator?.start()

        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}



extension AppDelegate {
    private func registerDependencies() {
        #warning("TODO: add working dependencies later")
    }

    private func registerMockDependencies() {
//        container.register(UserDefaultsService.self) { _ in
//            return UserDefaultsService()
//        }
        
        container.register(CoreDataStoring.self) { _ in
            return CoreDataStore.default
        }
        #warning("REMOVE ME")
        container.register(CoreDataManagerDescrption.self) { _ in
            return CoreDataManager()
        }
        
        container.register(UserServiceDescription.self) { _ in
            return MockUserService()
        }

        container.register(ImageServiceDescription.self) { _ in
            return MockImageService()
        }

        container.register(AuthServiceDescription.self) { _ in
            return MockAuthService()
        }

        container.register(AddressServiceDescription.self) { _ in
            return MockAddressesService()
        }

        container.register(ProductServiceDescription.self) { _ in
            return MockProductService()
        }
        
        container.register(OrderServiceDescription.self) { _ in
            return MockOrderService()
        }

        container.register(NotificationServiceDescription.self) { _ in
            return MockNotificationService()
        }
    }
}
