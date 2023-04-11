//
//  NotificationsController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit
import Swinject

protocol NotificationsCoordinatorDescription: Coordinator {
    //    @discardableResult func goToOrder2Screen(animated: Bool ) -> Self
    //    @discardableResult func goToOrder3Screen(animated: Bool) -> Self
}


class NotificationsCoordinator: NotificationsCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?

    var coreDataManager: CoreDataManagerDescrption?
    var notificationService: NotificationServiceDescription?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    
    func start() {
        notificationService = container?.resolve(NotificationServiceDescription.self)
        coreDataManager = container?.resolve(CoreDataManagerDescrption.self)
        goToNotifications()
    }
    
    func goToNotifications() {
        #warning("TODO: add normal userId")
        guard let notificationService, let coreDataManager else { return }
        let viewModel = NotificationsViewModel(userId: "",
                                               notificationsService: notificationService,
                                               coreDataManager: coreDataManager,
                                               coordinator: self)
        let notificationsVC = NotificationsViewController(viewModel: viewModel)
        navigationController.pushViewController(notificationsVC, animated: true)
    }
}
