//
//  AuthServiceDescription.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import Foundation

protocol AuthServiceDescription {
    func isAuthed() -> Bool
    func signIn(with phoneNumber: String,
                _ completion: @escaping (Result<User, Error>) -> Void)
    func signOut(for userId: String,
                 _ completion: @escaping (Result<Void, Error>) -> Void)
}

protocol UserDefaultsService {
    func getUserId() -> String
    func setUserId(with userId: String)
}
