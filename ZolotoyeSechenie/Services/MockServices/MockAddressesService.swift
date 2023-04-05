//
//  MockAddressesService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import Foundation

final class MockAddressesService: AddressesServiceDescription {
    func deleteAddress(with addressId: String, _ completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            completion(.success(()))
//            completion(.failure(ServiceError.deleteAddressFailture))
        }
    }
    
    func addAddress(for userId: String, with address: Address, _ completion: @escaping (Result<Address, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            completion(.success(MockData.address))
//            completion(.failure(ServiceError.addAddressFailture))
        }
    }
    
    func getAllAddresses(for userId: String, _ completion: @escaping (Result<[Address], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            completion(.success(MockData.addresses))
//            completion(.failure(ServiceError.fetchAddressesFailture))
        }
    }
    
    func getAddress(with id: String, _ completion: @escaping (Result<Address, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            completion(.success(MockData.address))
//            completion(.failure(ServiceError.fetchAddressInfoFailture))
        }
    }
    
    func updateAddress(for addressId: String, with address: Address, _ completion: @escaping (Result<Address, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            completion(.success(MockData.address))
//            completion(.failure(ServiceError.updateAddressFailture))
        }
    }
}
