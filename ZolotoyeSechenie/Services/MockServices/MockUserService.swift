//
//  MockProfileService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import Foundation

final class MockUserService: UserServiceDescription {
    func getUserInfo(for userId: String, _ completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(MockData.user))
//            completion(.failure(ServiceError.userInfoError))
        }
    }
    
    func editUserInfo(for userId: String, with newModel: User, _ completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(MockData.user))
//            completion(.failure(ServiceError.editingUserInfoFailture))
        }
    }
    
    func deleteUserInfo(for userId: String, _ completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(()))
//            completion(.failure(ServiceError.deletingUserFailture))
        }
    }
}
