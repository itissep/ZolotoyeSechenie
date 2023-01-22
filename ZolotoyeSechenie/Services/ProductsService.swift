//
//  ProductsService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import Foundation


protocol ProductsServiceProtocol {
    func getProducts(completion: @escaping (_ success: Bool, _ results: Products?, _ error: String?) -> ())
}

class ProductsService: ProductsServiceProtocol {
    func getProducts(completion: @escaping (Bool, Products?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://raw.githubusercontent.com/johncodeos-blog/MVVMiOSExample/main/demo.json", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Products.self, from: data!)
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
