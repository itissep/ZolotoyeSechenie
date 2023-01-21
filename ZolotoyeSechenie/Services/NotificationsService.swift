//
//  NotificationsService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import Foundation

protocol NotificationServiceProtocol {
    func getNotifications(completion: @escaping (_ success: Bool, _ results: Notifications?, _ error: String?) -> ())
}

struct NotificationsService: NotificationServiceProtocol {
    
    func getNotifications(completion: @escaping (Bool, Notifications?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://raw.githubusercontent.com/johncodeos-blog/MVVMiOSExample/main/demo.json", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Notifications.self, from: data!)
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
