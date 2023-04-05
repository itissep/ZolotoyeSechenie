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
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ZolotoyeSechenie")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
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
        
        container.register(UserServiceDescription.self) { _ in
            return MockUserService()
        }

        container.register(ImageServiceDescription.self) { _ in
            return MockImageService()
        }

        container.register(AuthServiceDescription.self) { _ in
            return MockAuthService()
        }

        container.register(AddressesServiceDescription.self) { _ in
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
