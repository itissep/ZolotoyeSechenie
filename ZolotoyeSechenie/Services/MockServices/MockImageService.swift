//
//  MockImageService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import UIKit

final class MockImageService: ImageServiceDescription {
    func uploadImage(for imageId: String, with image: UIImage, _ completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + K.loadingTime) {
            completion(.success(()))
//            completion(.failure(ServiceError.imageUploadFailture))
        }
    }
    
    func getImage(with imageId: String, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + K.loadingTime) {
            let image = UIImage.placeholder() ?? UIImage()
            completion(.success(image))
//            completion(.failure(ServiceError.imageFetchFailture))
        }
    }
}
