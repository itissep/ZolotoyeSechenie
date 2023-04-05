//
//  EditAddressViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 24.01.2023.
//

import Foundation

enum EditAddressType{
    case Edit(String)
    case Add
}


class EditAddressViewModel: NSObject {
//    private var addressService: AddressesServiceProtocol // TODO: userDefaults service
//
//    var address: Address? {
//        didSet {
//            reloadData?()
//        }
//    }
//    var type: EditAddressType
//    
//    var reloadData: (() -> Void)?
//    
//    
//    init(addressService: AddressesServiceProtocol = AddressesMockService(), type: EditAddressType) {
//        self.type = type
//        self.addressService = addressService
//    }
//    
//    func getData() {
//        switch type {
//        case .Add:
//            print("get data case .Add")
//        case .Edit(let id):
//            addressService.getAddressById(id: id) { success, result, error in
//                if let error = error {
//                    print(error)
//                } else {
//                    self.address = result
//                }
//            }
//        }
//    }
//    
//    func getTitle() -> String {
//        switch type {
//        case .Add:
//            return "Добавить адрес"
//        case .Edit:
//            return "Редактировать адрес"
//        }
//    }
//    
//    func safeData(with address: Address){
//        switch type {
//        case .Edit(let id):
//            print("addreess edited \(id)")
//            // TODO: edit address by id with new data
//        case .Add:
//            print("address added")
//            // TODO: add address by id
//        }
//    }
}
