//
//  UserServiceDescription.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 11.04.2023.
//

import Foundation

protocol UserServiceDescription {
    func getUserInfo(for userId: String,
                     _ completion: @escaping (Result<User, Error>) -> Void)
    func editUserInfo(for userId: String,
                      with newModel: User,
                      _ completion: @escaping (Result<User, Error>) -> Void)
    func deleteUserInfo(for userId: String,
                        _ completion: @escaping (Result<Void, Error>) -> Void)
}
