//
//  AddressesService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation

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
