//
//  AuthCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import UIKit
import Swinject

protocol AuthCoordinatorDescription: Coordinator {
    func goToHome()
    func goToSignInScreen()
    func goToConfirmationScreen(with service: AuthServiceDescription, withNumber number: String)
}

class AuthCoordinator: AuthCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?
//    var authService: AuthServiceDescription?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        print("AuthCoordinator start")
//        guard let container else { return }
//        authService = container.resolve(AuthServiceDescription.self)
        goToSignInScreen()
    }

    func goToSignInScreen() {
//        guard let authService = authService else { return }
//        let viewModel = SignInViewModel(service: authService, coordinator: self)
        let signInVC = SignInViewController()

        navigationController.pushViewController(signInVC, animated: true)
    }

    func goToConfirmationScreen(with service: AuthServiceDescription, withNumber number: String) {
//        guard let authService = authService else { return }
//
//        let viewModel = ConfirmationViewModel(service: authService, phoneNumber: number, coordinator: self)
//        let confirmationVC = ConfirmationViewController(viewModel: viewModel)
//        navigationController.pushViewController(confirmationVC, animated: true)
    }

    func goToHome() {
        guard let appC = parentCoordinator as? AppCoordinatorDescription else {
            return
        }
        appC.goToHome()
        parentCoordinator?.childDidFinish(self)
    }

    deinit {
        print("AuthCoordinator Deinit")
    }
}
