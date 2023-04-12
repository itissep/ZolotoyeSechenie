//
//  CoreDataStore.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 11.04.2023.
//

import Foundation
import CoreData

enum StorageType {
    case persistent, inMemory
}

extension NSManagedObject {
    class var entityName: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

protocol EntityCreating {
    var viewContext: NSManagedObjectContext { get }
    func createEntity<T: NSManagedObject>() -> T
}

extension EntityCreating {
    func createEntity<T: NSManagedObject>() -> T {
        T(context: viewContext)
    }
}

protocol CDFetchResultsPublishing {
    var viewContext: NSManagedObjectContext { get }
    func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>) -> CDFetchResultsPublisher<T>
}

extension CDFetchResultsPublishing {
    func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>) -> CDFetchResultsPublisher<T> {
        return CDFetchResultsPublisher(request: request, context: viewContext)
    }
}

protocol CDDeleteModelPublishing {
    var viewContext: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }
    func delete(_ request: NSFetchRequest<NSFetchRequestResult>) -> CDDeleteModelPublisher
}

extension CDDeleteModelPublishing {
    func delete(_ request: NSFetchRequest<NSFetchRequestResult>) -> CDDeleteModelPublisher {
        return CDDeleteModelPublisher(delete: request, context: viewContext)
    }
}

protocol CDSaveModelPublishing {
    var viewContext: NSManagedObjectContext { get }
    func save(_ action: @escaping Action) -> CDSaveModelPublisher
}

extension CDSaveModelPublishing {
    func save(_ action: @escaping Action) -> CDSaveModelPublisher {
        return CDSaveModelPublisher(action: action, context: viewContext)
    }
}

protocol CoreDataStoring: EntityCreating, CDFetchResultsPublishing, CDDeleteModelPublishing, CDSaveModelPublishing {
    var viewContext: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }
}

class CoreDataStore: CoreDataStoring {
    
    private let container: NSPersistentContainer
    
    static var `default`: CoreDataStoring = {
        return CoreDataStore(name: "DataBase", in: .persistent)
    }()
    
    var viewContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        return self.container.newBackgroundContext()
    }
    
    
    init(name: String, in storageType: StorageType) {
        self.container = NSPersistentContainer(name: name)
        self.setupIfMemoryStorage(storageType)
        self.container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    private func setupIfMemoryStorage(_ storageType: StorageType) {
        if storageType  == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.container.persistentStoreDescriptions = [description]
        }
    }
}
