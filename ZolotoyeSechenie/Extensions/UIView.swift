//
//  UIView.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 12.04.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for viewToAdd in views {
            viewToAdd.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(viewToAdd)
        }
    }
}
