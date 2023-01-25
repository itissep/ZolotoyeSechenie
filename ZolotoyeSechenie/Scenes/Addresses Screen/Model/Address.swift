//
//  Address.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation


typealias Addresses = [Address]

struct Address: Codable, Equatable {
    let id: String
    let city: String
    let district: String
    let street: String
    let building: String
    let apartment: String
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
