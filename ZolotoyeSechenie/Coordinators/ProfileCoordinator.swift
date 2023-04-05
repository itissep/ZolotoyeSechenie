//
//  ProfileCoordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import UIKit
import Swinject

protocol ProfileCoordinatorDescription: Coordinator {
    func goToProfile()
    func goToEditProfileScreen(with userId: String)
    func goToSignIn()
}

class ProfileCoordinator: ProfileCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?

//    var userService: UserServiceDescription?
//    var imageService: ImageServiceDescription?
//    var userDefaultsService: UserDefaultsService?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
//        userService = container?.resolve(UserServiceDescription.self)
//        imageService = container?.resolve(ImageServiceDescription.self)
//        userDefaultsService = container?.resolve(UserDefaultsService.self)

        goToProfile()
    }

    func goToProfile() {
//        guard
//            let userDefaultsService,
//            let userService,
//            let imageService,
//            let userId = userDefaultsService.getString(with: .userId)
//        else {
//            return
//        }
        let viewModel = ProfileViewModel(userId: "")
        let profileVC = ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(profileVC, animated: true)
    }

    func goToEditProfileScreen(with userId: String) {
//        guard let userService, let imageService else {
//            return
//        }
//
//        let viewModel = EditProfileViewModel(userService: userService, imageService: imageService, coordinator: self)
//        let editProfileVC = EditProfileViewController(viewModel: viewModel)
//
//        navigationController.pushViewController(editProfileVC, animated: true)
    }

    func goToSignIn() {

    }
}
