//
//  MockAuthService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import Foundation

final class MockAuthService: AuthServiceDescription {
    func isAuthed() -> Bool {
        return true
    }
    
    func signIn(with phoneNumber: String, _ completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + K.loadingTime) {
            completion(.success(MockData.user))
//            completion(.failure(ServiceError.sighInFailture))
        }
    }
    
    func signOut(for userId: String, _ completion: @escaping (Result<Void, Error>) -> Void) {
        // what should i do with app in this case?
        // maybe that is the way to keep only one logged in client with one userId??
        
        // delele userId from userDefaults, clear cashe and favourites from core data
        DispatchQueue.main.asyncAfter(deadline: .now() + K.loadingTime) {
            completion(.success(()))
//            completion(.failure(ServiceError.sighInFailture))
            
        }
    }
}
