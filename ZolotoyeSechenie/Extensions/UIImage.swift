//
//  UIImage.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import UIKit

extension UIImage {
    static func placeholder() -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: 10, weight: .medium)
        let image = UIImage(systemName: "photo.fill", withConfiguration: configuration)?.withTintColor(K.Colors.prettyGold, renderingMode: .alwaysOriginal)
        return image
    }
    
    static func systemWithConfig(name: String, size: CGFloat = 20, tintColor: UIColor = K.Colors.darkGold) -> UIImage? {
        return UIImage(systemName: name,
                       withConfiguration: UIImage.SymbolConfiguration(pointSize: size, weight: .regular)
                    )?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
    }
}
