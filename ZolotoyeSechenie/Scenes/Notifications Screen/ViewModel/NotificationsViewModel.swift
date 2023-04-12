//
//  NotificationsViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import Foundation
import Combine
import CoreData

class NotificationsViewModel: NSObject {
    
    private let coreDataStore: CoreDataStoring
    private var notificationsService: NotificationServiceDescription
    private let userId: String
    private let coordinator: NotificationsCoordinatorDescription
    
    @Published var notificationCellViewModels = [NotificationCellViewModel]()
    @Published var isLoading = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(userId: String,
         notificationsService: NotificationServiceDescription,
         coreDataStore: CoreDataStoring,
         coordinator: NotificationsCoordinatorDescription) {
        self.notificationsService = notificationsService
        self.coreDataStore = coreDataStore
        self.userId = userId
        self.coordinator = coordinator
        super.init()
        
        isLoading = true
        getCachedData()
        getNotifications()
    }
    
    private func getCachedData() {
        let request = NSFetchRequest<UserNotificationMO>(entityName: UserNotificationMO.entityName)
        coreDataStore
            .fetch(request)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: {[weak self] notifications in
                self?.fetchData(notifications.map({ UserNotification(from: $0) }))
            }
            .store(in: &subscriptions)
    }
    
    private func replaceCache(with notifications: [UserNotification]) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: UserNotificationMO.entityName)
        coreDataStore
            .delete(request)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { _ in
            }
            .store(in: &subscriptions)
        
        
        let action: Action = {
            notifications.forEach {[weak self] newNotification in
                guard let self else { return }
                let notificationMO: UserNotificationMO = self.coreDataStore.createEntity()
                
                notificationMO.id = newNotification.id
                notificationMO.title = newNotification.title
                notificationMO.message = newNotification.message
                notificationMO.date = newNotification.date
                notificationMO.image = newNotification.image
            }
        }
        
        coreDataStore
            .save(action)
            .sink { completion in
                if case .failure(let error) = completion {
                    #warning("TODO: error handler")
                    print(error)
                }
            } receiveValue: { _ in
            }
            .store(in: &subscriptions)
    }
    
    func getNotifications() {
        notificationsService.getAllNotifications(for: userId) {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.isLoading = false
                #warning("TODO: add error handler")
            case .success(let notifications):
                self?.replaceCache(with: notifications)
                self?.fetchData(notifications)
            }
        }
    }
    
    func fetchData(_ notifications: [UserNotification]) {
        var vms = [NotificationCellViewModel]()
        for notification in notifications {
            vms.append(createCellModel(notification: notification))
        }
        notificationCellViewModels = vms.sorted(by: { $0.date < $1.date })
        isLoading = false
    }
    
    func createCellModel(notification: UserNotification) -> NotificationCellViewModel {
        return NotificationCellViewModel(from: notification)
    }
    
    func reloadData() {
        getNotifications()
    }
}
