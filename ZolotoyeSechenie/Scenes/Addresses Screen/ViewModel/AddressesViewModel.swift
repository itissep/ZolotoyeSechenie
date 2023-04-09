//
//  AddressesViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation
import Combine

class AddressesViewModel: NSObject {
    private var addressService: AddressServiceDescription
    private var userId: String

    @Published var isLoading = false
    var addressCellViewModels = [AddressCellViewModel]()
    private let coordinator: ProfileCoordinatorDescription

    init(userId: String,
         addressService: AddressServiceDescription,
         coordinator: ProfileCoordinatorDescription) {
        self.addressService = addressService
        self.coordinator = coordinator
        self.userId = userId
        super.init()
        
        isLoading = true
        fetchData() 
    }
    
    public func reload() {
        fetchData()
    }
    
    private func fetchData() {
        addressService.getAllAddresses(for: userId) {[weak self] result in
            switch result {
            case .failure(let error):
                #warning("TODO: error handling ")
                print(error)
                self?.isLoading = false
            case .success(let addresses):
                self?.toCellModels(addresses)
            }
        }
    }
    
    private func toCellModels(_ models: [Address]) {
        var viewModels: [AddressCellViewModel] = []
        for model in models {
            let viewModel = createCellModel(for: model)
            viewModels.append(viewModel)
        }
        addressCellViewModels = viewModels
        isLoading = false
    }
    
    private func createCellModel(for address: Address) -> AddressCellViewModel {
        return AddressCellViewModel(from: address)
    }
    
    func goToAddress(_ type: EditAddressType) {
        coordinator.goToAddress(type)
    }
}
