//
//  EditAddressViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 24.01.2023.
//

import Foundation
import Combine

enum EditAddressType{
    case Edit(String)
    case Add
}

class EditAddressViewModel: NSObject {
    private let addressService: AddressServiceDescription
    private let coordinator: ProfileCoordinatorDescription
    private var userId: String
    
    @Published var isLoading = false
    @Published var title: String?
    @Published var addressInfo: Address?
    @Published var error: String?
    #warning("TODO: change error to alert with title and message")
    
    init(userId: String, type: EditAddressType, addressService: AddressServiceDescription, coordinator: ProfileCoordinatorDescription) {
        self.userId = userId
        self.addressService = addressService
        self.coordinator = coordinator
        super.init()
        
        setup(with: type)
        title = configureTitle(with: type)
    }
    
    private func setup(with type: EditAddressType) {
        isLoading = true
        switch type {
        case .Edit(let addressId):
            self.fetchAddressInfo(with: addressId)
        case .Add:
            isLoading = false
        }
    }
    
    private func configureTitle(with type: EditAddressType) -> String {
        switch type {
        case .Edit(_):
            return "Изменение адреса"
        case .Add:
            return "Новый адрес"
        }
    }
    
    private func fetchAddressInfo(with addressId: String) {
        addressService.getAddress(with: addressId) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.isLoading = true
                self?.error = error.localizedDescription
            case .success(let address):
                self?.addressInfo = address
                self?.isLoading = false
            }
        }
    }
    
    public func saveAddress(_ address: Address) {
        guard wasEdited(address) else {
            error = "Вы ничего не изменили."
            return
        }
        isLoading = true
        addressService.putAddress(for: userId, with: address) {[weak self] result in
            switch result {
            case .failure(let error):
                self?.isLoading = false
                self?.error = error.localizedDescription
            case .success(_ ):
                self?.isLoading = false
                #warning("TODO: show alert with success")
            }
        }
    }
    
    public func goBack() {
        coordinator.navigationController.popViewController(animated: true)
    }
    
    public func wasEdited(_ newAddress: Address) -> Bool {
        if let oldAddress = addressInfo {
            return oldAddress != newAddress
        } else {
            return true
        }
    }
}
