//
//  AddressesService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation

protocol AddressesServiceProtocol {
    func getAddresses(completion: @escaping (_ success: Bool, _ results: Addresses?, _ error: String?) -> ())
    func getAddressById(id: String, completion: @escaping (_ success: Bool, _ result: Address?, _ error: String?) -> ())
    func updateAddress(with address: Address, completion: @escaping (_ success: Bool, _ error: String?) -> ())
}

struct AddressesService:AddressesServiceProtocol {
    
    func getAddresses(completion: @escaping (Bool, Addresses?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://raw.githubusercontent.com/johncodeos-blog/MVVMiOSExample/main/demo.json", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Addresses.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Addresses to model")
                }
            } else {
                completion(false, nil, "Error: Addresses GET Request failed")
            }
        }
    }
    
    func getAddressById(id: String, completion: @escaping (_ success: Bool, _ result: Address?, _ error: String?) -> ()) {
        // TODO: just to do
    }
    
    func updateAddress(with address: Address, completion: @escaping (Bool, String?) -> ()) {
        // TODO: just do it
    }
    
}




struct AddressesMockService:AddressesServiceProtocol {
    
    
    func getAddresses(completion: @escaping (Bool, Addresses?, String?) -> ()) {
        let model = MockData.Addresses.model
        completion(true, model, nil)
    }
    
    func getAddressById(id: String, completion: @escaping (_ success: Bool, _ result: Address?, _ error: String?) -> ()) {
        let model = MockData.Addresses.model
        var result: Address? = nil
        for item in model {
            if item.id == id {
                result = item
            }
        }
        if let result = result {
            completion(true, result, nil)
        } else {
            completion(false, result, "no addresses with this id")
        }
        
    }
    
    func updateAddress(with address: Address, completion: @escaping (Bool, String?) -> ()) {
        
        let model = MockData.Addresses.model
        var newModels = model.filter { $0.id != address.id }
        newModels.append(address)

        if model == newModels {
            MockData.Addresses.model = newModels
            completion(false, "nothing changed")
            
        } else {
            completion(true, nil)
        }
    }
    
    
}
