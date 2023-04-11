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
    private let coreDataManager: CoreDataManagerDescrption
    private var userId: String

    @Published var isLoading = false
    var addressCellViewModels = [AddressCellViewModel]()
    private let coordinator: ProfileCoordinatorDescription

    init(userId: String,
         addressService: AddressServiceDescription,
         coreDataManager: CoreDataManagerDescrption,
         coordinator: ProfileCoordinatorDescription) {
        self.addressService = addressService
        self.coreDataManager = coreDataManager
        self.coordinator = coordinator
        self.userId = userId
        super.init()
        
        isLoading = true
        getCachedData()
        fetchAddresses()
    }
    
    public func reload() {
        fetchAddresses()
    }
    
    private func getCachedData() {
        coreDataManager.initIfNeeded {[weak self] in
            let request = AddressMO.fetchRequest()
            guard let addressesMO = self?.coreDataManager.fetch(request: request) else { return }
            let addressModels = addressesMO.map { Address(from: $0) }
            self?.fetchData(addressModels)
        } errorBlock: { error in
            print(error)
            #warning("TODO: add error handler")
        }
    }
    
    private func replaceCache(with addresses: [Address]) {
        coreDataManager.initIfNeeded {[weak self] in
            self?.coreDataManager.deleteAll(request: AddressMO.fetchRequest())
            
            addresses.forEach { newAddress in
                self?.coreDataManager.create(entityName: EntitiesDB.AddressMO.rawValue, configurationBlock: { addressMO in
                    guard let addressMO = addressMO as? AddressMO else { return }
                    addressMO.id = newAddress.id
                    addressMO.city = newAddress.city
                    addressMO.disctrict = newAddress.district
                    addressMO.street = newAddress.street
                    addressMO.building = newAddress.building
                    addressMO.apartment = newAddress.apartment
                    addressMO.comment = newAddress.comment
                    addressMO.userId = newAddress.userId
                })
            }
        } errorBlock: { error in
            print(error)
            #warning("TODO: error handler")
        }
    }
    
    private func fetchAddresses() {
        addressService.getAllAddresses(for: userId) {[weak self] result in
            switch result {
            case .failure(let error):
                #warning("TODO: error handling ")
                print(error)
                self?.isLoading = false
            case .success(let addresses):
                self?.fetchData(addresses)
                self?.replaceCache(with: addresses)
            }
        }
    }
    
    private func fetchData(_ models: [Address]) {
        var viewModels: [AddressCellViewModel] = []
        for model in models {
            let viewModel = createCellModel(for: model)
            viewModels.append(viewModel)
        }
        addressCellViewModels = viewModels.sorted(by: { $0.title < $1.title })
        isLoading = false
    }
    
    private func createCellModel(for address: Address) -> AddressCellViewModel {
        return AddressCellViewModel(from: address)
    }
    
    func goToAddress(_ type: EditAddressType) {
        coordinator.goToAddress(type)
    }
}
