//
//  UIActivityIndicatorView.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import UIKit

extension UIActivityIndicatorView {
    func scaleIndicator(factor: CGFloat) {
        transform = CGAffineTransform(scaleX: factor, y: factor)
    }
}
