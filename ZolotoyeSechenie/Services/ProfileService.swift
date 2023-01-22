//
//  ProfileService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import Foundation


protocol ProfileServiceProtocol {
    func getDeliveriesCount(completion: @escaping (_ success: Bool, _ result: Int?, _ error: String?) -> ())
}

struct ProfileService: ProfileServiceProtocol {
    func getDeliveriesCount(completion: @escaping (Bool, Int?, String?) -> ()) {
//        HttpRequestHelper().GET(url: "https://raw.githubusercontent.com/johncodeos-blog/MVVMiOSExample/main/demo.json", params: ["": ""], httpHeader: .application_json) { success, data in
//            if success {
//                do {
//                    let model = try JSONDecoder().decode(Products.self, from: data!)
//                    completion(true, model, nil)
//                } catch {
//                    completion(false, nil, "Error: Trying to parse Employees to model")
//                }
//            } else {
//                completion(false, nil, "Error: Employees GET Request failed")
//            }
//        }
        completion(true, 5, nil)
    }
}
