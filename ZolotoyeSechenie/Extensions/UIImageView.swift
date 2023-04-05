//
//  UIImageView.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 06.04.2023.
//

import UIKit

extension UIImageView {
    func loadImage(at url: URL) {
        ImageService.shared.load(url, for: self)
    }
    
    func cancelImageLoad() {
        ImageService.shared.cancel(for: self)
    }
    
    func placeholder() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let image = UIImage(systemName: "photo.fill",
                            withConfiguration: configuration)?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        self.image = image
        self.backgroundColor = .lightGray.withAlphaComponent(0.2)
        self.contentMode = .center
    }
}
