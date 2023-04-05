//
//  ImageServiceDescription.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import UIKit

protocol ImageServiceDescription {
    func getImage(with imageId: String,
                  _ completion: @escaping (Result<UIImage, Error>) -> Void)
    func uploadImage(for imageId: String,
                     with image: UIImage,
                     _ completion: @escaping (Result<Void, Error>) -> Void)
}
