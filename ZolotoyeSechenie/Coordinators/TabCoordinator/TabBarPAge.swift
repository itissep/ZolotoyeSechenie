//
//  TabBarPAge.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//

import UIKit

enum TabBarPage {
    
    case feed
    case search
    case cart
    case notifications
    case profile
    

    init?(index: Int) {
        switch index {
        case 0:
            self = .feed
        case 1:
            self = .search
        case 2:
            self = .cart
        case 3:
            self = .notifications
        case 4:
            self = .profile
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .feed:
            return "Лента"
        case .cart:
            return "Корзина"
        case .search:
            return "Поиск"
        case .profile:
            return "Профиль"
        case .notifications:
            return "Уведомления"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .feed:
            return 0
        case .search:
            return 1
        case .cart:
            return 2
        case .notifications:
            return 3
        case .profile:
            return 4
        }
    }
    
    func pageImage() -> UIImage {
        switch self {
        case .feed:
            return K.Icons.houseFill
        case .search:
            return K.Icons.magnifyingglassFill
        case .cart:
            return K.Icons.cart
        case .notifications:
            return K.Icons.bellFill
        case .profile:
            return K.Icons.personFill
        }
    }

    // Add tab icon value
    
    // Add tab icon selected / deselected color
    
    // etc
}


