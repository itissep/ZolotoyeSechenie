//
//  AddressesViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation


class AddressesViewModel: NSObject {
    
    //    private var addressesService: AddressesServiceProtocol
    //
    //    var reloadTableView: (() -> Void)?
    //
    //    var addresses = Addresses()
    //
    //    var addressCellViewModels = [AddressCellViewModel]() {
    //        didSet {
    //            reloadTableView?()
    //        }
    //    }
    //
    //    init(addressesService: AddressesServiceProtocol = AddressesMockService()) {
    //        self.addressesService = addressesService
    //    }
    //
    //    func getAddresses() {
    //        // TODO: change to real service
    //        addressesService.getAddresses { success, model, error in
    //            if success, let addresses = model {
    //                self.fetchData(addresses: addresses)
    //            } else {
    //                print(error!)
    //            }
    //        }
    //    }
    //
    //    func fetchData(addresses: Addresses) {
    //        self.addresses = addresses // Cache
    //        var vms = [AddressCellViewModel]()
    //        for address in addresses {
    //            vms.append(createCellModel(address: address))
    //        }
    //        addressCellViewModels = vms
    //    }
    //
    //    func createCellModel(address: Address) -> AddressCellViewModel {
    //        let id = address.id
    //        let title = "ул. \(address.street), д. \(address.building)"
    //        let message = "г. \(address.city), \(address.district) р-н."
    //        let index = "индекс ли?"
    //
    //        let cellViewModel = AddressCellViewModel(id: id, title: title, message: message, index: index)
    //        return cellViewModel
    //    }
    //
    //    func getCellViewModel(at indexPath: IndexPath) -> AddressCellViewModel {
    //        return addressCellViewModels[indexPath.row]
    //    }
    //}
}
