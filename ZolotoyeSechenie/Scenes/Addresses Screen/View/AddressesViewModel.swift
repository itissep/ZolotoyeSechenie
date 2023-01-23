//
//  AddressesViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation


class AddressesViewModel: NSObject {
    
    private var addressesService: AddressesServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var addresses = Addresses()
    
    var addressCellViewModels = [AddressCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(addressesService: AddressesServiceProtocol = AddressesService()) {
        self.addressesService = addressesService
    }
    
    func getAddresses() {
        addressesService.getAddresses { success, model, error in
            if success, let addresses = model {
                self.fetchData(addresses: addresses)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(addresses: Addresses) {
        self.addresses = addresses // Cache
        var vms = [AddressCellViewModel]()
        for address in addresses {
            vms.append(createCellModel(address: address))
        }
        addressCellViewModels = vms
    }
    
    func createCellModel(address: Address) -> AddressCellViewModel {
        let id = address.id
        // TODO: change data later
        return AddressCellViewModel(id: id) // change properties
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> AddressCellViewModel {
        return addressCellViewModels[indexPath.row]
    }
}


typealias Addresses = [Address]

struct Address: Codable {
    let id: String
//    let title: String
//    let message: String
//    let image: String
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case employeeName = "employee_name"
//        case employeeSalary = "employee_salary"
//        case employeeAge = "employee_age"
//    }
}


struct AddressCellViewModel {
    let id: String
    let title: String = "ул. Гороховая, д. 109"
    let message: String = "г. Санкт-Петербург, Адмиралтейский р-н."
    let index: String = "123456"
    
}


protocol AddressesServiceProtocol {
    func getAddresses(completion: @escaping (_ success: Bool, _ results: Addresses?, _ error: String?) -> ())
}

struct AddressesService:AddressesServiceProtocol {
    
    func getAddresses(completion: @escaping (Bool, Addresses?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://raw.githubusercontent.com/johncodeos-blog/MVVMiOSExample/main/demo.json", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Addresses.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Employees to model")
                }
            } else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        }
    }
}
