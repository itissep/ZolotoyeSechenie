//
//  CourierDetailtsViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 12.04.2023.
//

import Foundation
import Combine

#warning("TODO: add core data here")
final class CourierDetailsViewModel: NSObject {
    let coordinator: OrderCoordinatorDescription
    let addressService: AddressServiceDescription
    
    @Published var addressSelectionViewModels: [PickerViewModel] = []
    
    init(addressService: AddressServiceDescription, coordinator: OrderCoordinatorDescription) {
        self.coordinator = coordinator
        self.addressService = addressService
        super.init()
        
        getAddresses()
    }
    
    private func getAddresses() {
        addressService.getAllAddresses(for: "") {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                #warning("TODO: add error handler")
            case .success(let addreses):
                self?.addressSelectionViewModels = addreses.map({ PickerViewModel(from: $0 )})
            }
        }
    }
    
    public func getDistrictCapture() -> String {
        return "Для данного района стоимость доставки 100 рублей. \nПри заказе от 5000 - доставка бесплатно."
    }
    
    public func goToAddAddress() {
        coordinator.goToAddNewAddress()
    }
    
    public func goToNextScreen() {
        coordinator.goToPaymentMethodPicker()
    }
}
