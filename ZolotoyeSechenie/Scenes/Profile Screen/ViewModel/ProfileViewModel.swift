//
//  ProfileViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import Foundation
import Combine

class ProfileViewModel: NSObject {
    private let userService: UserServiceDescription
    private let orderService: OrderServiceDescription
    private let userId: String
    
    @Published var deliveriesCount = 0
    @Published var userInfo: User?
    @Published var isLoading: Bool = false
    @Published var settingsViewModels: [SettingsCellViewModel] = []
    
    let dispatchGroup = DispatchGroup()
    let queue = DispatchQueue(label: "ru.zolotoyesechenie.queue.profile", qos: .background)
    
    let coordinator: ProfileCoordinatorDescription

    
    init(userId: String,
         userService: UserServiceDescription,
         orderService: OrderServiceDescription,
         coordinator: ProfileCoordinatorDescription) {
        self.userService = userService
        self.orderService = orderService
        self.userId = userId
        self.coordinator = coordinator
        super.init()
        
        getData()
        createSettingsModels()
    }
    
    private func getData() {
        isLoading = true
        dispatchGroup.enter()
        orderService.getDelieveriesCount(for: userId) {[weak self] result in
            switch result {
            case .failure(let error):
                #warning("TODO: error handling")
                print(error)
                self?.dispatchGroup.leave()
            case .success(let count):
                self?.deliveriesCount = count
                self?.dispatchGroup.leave()
            }
        }
        dispatchGroup.enter()
        userService.getUserInfo(for: userId) {[weak self] result in
            switch result {
            case .failure(let error):
                #warning("TODO: error handling")
                print(error)
                self?.dispatchGroup.leave()
            case .success(let userInfo):
                self?.userInfo = userInfo
                self?.dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: queue) { [weak self] in
            self?.isLoading = false
        }
    }
    
    private func createSettingsModels() {
        var models: [SettingsCellViewModel] = []
        
        for type in ProfileSettingsType.allCases {
            let image = type.getIcon()
            let model = SettingsCellViewModel(title: type.rawValue, image: image, type: type)
            models.append(model)
        }
        settingsViewModels = models
    }
    
    func goToScreen(for type: ProfileSettingsType) {
        switch type {
        case .addresses:
            coordinator.goToAllAddresses()
        case .history:
            coordinator.goToHistory()
        default:
            break
        }
    }
    
    func sighOutWasPressed() {
        
    }
    
    func deleteProfileWasPressed() {
        
    }
}
