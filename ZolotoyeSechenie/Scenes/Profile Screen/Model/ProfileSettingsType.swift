//
//  ProfileSettingsType.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import UIKit

enum ProfileSettingsType: String, CaseIterable {
    case addresses = "Адреса доставки"
    case payments = "Способы оплаты"
    case history = "История заказов"
    case deleteProfile = "Удалить профиль"
    case signOut = "Выйти из профиля"

    func getIcon() -> UIImage? {
        let image: UIImage
        switch self {
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
        return image
    }
}
