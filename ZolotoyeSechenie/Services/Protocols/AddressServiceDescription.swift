//
//  AddressServiceDescription.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 11.04.2023.
//

import Foundation

protocol AddressServiceDescription {
    func getAllAddresses(for userId: String, _ completion: @escaping (Result<[Address], Error>) -> Void)
    func getAddress(with id: String,_ completion: @escaping (Result<Address, Error>) -> Void)
    func updateAddress(for addressId: String, with address: Address,_ completion: @escaping (Result<Address, Error>) -> Void)
    func putAddress(for userId: String, with address: Address, _ completion: @escaping (Result<Address, Error>) -> Void)
    func deleteAddress(with addressId: String, _ completion: @escaping (Result<Void, Error>) -> Void)
}
