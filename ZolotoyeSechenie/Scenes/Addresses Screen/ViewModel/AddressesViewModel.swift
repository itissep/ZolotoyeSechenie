//
//  AddressesViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation
import Combine
import CoreData

class AddressesViewModel: NSObject {
    private var addressService: AddressServiceDescription
    private let coreDataManager: CoreDataStoring
    private var userId: String

    @Published var isLoading = false
    var addressCellViewModels = [AddressCellViewModel]()
    private let coordinator: ProfileCoordinatorDescription
    
    private var subscriptions = Set<AnyCancellable>()

    init(userId: String,
         addressService: AddressServiceDescription,
         coreDataManager: CoreDataStoring,
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
        let request = NSFetchRequest<AddressMO>(entityName: AddressMO.entityName)
            coreDataManager
                .publicher(fetch: request)
                .sink { completion in
                    if case .failure(let error) = completion {
                        print(error)
                    }
                } receiveValue: {[weak self] addresses in
                    self?.fetchData(addresses.map({ Address(from: $0) }))
                }
                .store(in: &subscriptions)
    }
    
    private func replaceCache(with addresses: [Address]) {
        print("wowza")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: AddressMO.entityName)
            coreDataManager
                .publicher(delete: request)
                .sink { completion in
                    if case .failure(let error) = completion {
                        print(error)
                    }
                } receiveValue: { _ in
                }
                .store(in: &subscriptions)
        
        
        let action: Action = {
            addresses.forEach {[weak self] newAddress in
                guard let self else { return }
                let addressMO: AddressMO = self.coreDataManager.createEntity()
                
                addressMO.id = newAddress.id
                addressMO.city = newAddress.city
                addressMO.disctrict = newAddress.district
                addressMO.street = newAddress.street
                addressMO.building = newAddress.building
                addressMO.apartment = newAddress.apartment
                addressMO.comment = newAddress.comment
                addressMO.userId = newAddress.userId
                
            }
        }
        
        coreDataManager
            .publicher(save: action)
            .sink { completion in
                if case .failure(let error) = completion {
                    #warning("TODO: error handler")
                    print(error)
                }
            } receiveValue: { _ in
            }
            .store(in: &subscriptions)
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
