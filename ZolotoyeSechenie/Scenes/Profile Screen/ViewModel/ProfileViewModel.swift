//
//  ProfileViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import UIKit

class ProfileViewModel: NSObject {
    private var profileService: ProfileServiceProtocol
    
    var settings: [ProfileSettingsType] =
    [.addresses, .history, .deleteProfile, .signOut]
    
    var deliveriesCount = 0 {
        didSet {
            reloadData?()
        }
    }
    
    
    lazy var settingsViewModels: [SettingsCellViewModel] = []
    
    var reloadData: (() -> Void)?
    
    
    init(userId: String) {
        self.profileService = ProfileService()
    }
    
    func getData() {
        settingsViewModels = createSettingsModels()
        profileService.getDeliveriesCount { success, result, error in
            if success, let count = result {
                self.deliveriesCount = count
            } else {
                print(error!)
            }
        }
    }
    
    
    func createSettingsModels() -> [SettingsCellViewModel]{
        var models: [SettingsCellViewModel] = []
        
        for item in settings {
            let image: UIImage
            switch item {
            case .addresses:
                image = K.Icons.Settings.addresses
            case .deleteProfile:
                image = K.Icons.Settings.delete
            case .signOut:
                image = K.Icons.Settings.signOut
            case .history:
                image = K.Icons.Settings.history
            case .payments:
                image = K.Icons.Settings.payments
            }
            
            let model = SettingsCellViewModel(title: item.rawValue, image: image, type: item)
            models.append(model)
            
            
        }
        return models
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> SettingsCellViewModel {
        return settingsViewModels[indexPath.row]
    }
}
