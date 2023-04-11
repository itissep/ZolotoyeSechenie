//
//  CoreDataManager.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 11.04.2023.
//

import Foundation
import CoreData

protocol CoreDataManagerDescrption {
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T]
    func count<T: NSManagedObject>(request: NSFetchRequest<T>) -> Int
    
    func create<T: NSManagedObject>(entityName: String, configurationBlock: @escaping (T?) -> Void)
    
    func delete<T: NSManagedObject>(request: NSFetchRequest<T>)
    func deleteAll(request: NSFetchRequest<NSFetchRequestResult>)
    
    func update<T: NSManagedObject>(reqeust: NSFetchRequest<T>, configurationBlock: @escaping (T?) -> Void)
    
    func initIfNeeded(successBlock: (() -> ())?, errorBlock: ((Error) -> ())?)
    
    var viewContext: NSManagedObjectContext { get }
}

final class CoreDataManager {
    
    private var isReady: Bool = false
    private let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: "DataBase")
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

}

extension CoreDataManager: CoreDataManagerDescrption {
    func initIfNeeded(successBlock: (() -> ())?, errorBlock: ((Error) -> ())?) {
        guard !isReady else {
            successBlock?()
            return
        }
        
        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                errorBlock?(error)
                return
            }
            
            self?.isReady = true
            successBlock?()
        }
    }
    
    func update<T>(reqeust: NSFetchRequest<T>, configurationBlock: @escaping (T?) -> Void) where T: NSManagedObject {
        
        let objects = fetch(request: reqeust)
        
        guard let object = objects.first else {
            return
        }
        
        viewContext.performAndWait {
            configurationBlock(object)
            try? viewContext.save()
        }
    }
    
    func deleteAll(request: NSFetchRequest<NSFetchRequestResult>) {
        let batchRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        viewContext.performAndWait { [weak self] in
            _ = try? self?.viewContext.execute(batchRequest)
            try? self?.viewContext.save()
        }
    }
    
    func delete<T>(request: NSFetchRequest<T>) where T: NSManagedObject {
        
        viewContext.perform { [weak self] in
            let objects = self?.fetch(request: request)
            
            objects?.forEach({ self?.viewContext.delete($0) })
            
            try? self?.viewContext.save()
        }
    }
    
    func create<T>(entityName: String, configurationBlock: @escaping (T?) -> Void) where T: NSManagedObject {
        
        container.performBackgroundTask({ backgroundContext in
            let object = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                             into: backgroundContext) as? T
            
            configurationBlock(object)
            
            try? backgroundContext.save()
        })
    }
    
    func count<T>(request: NSFetchRequest<T>) -> Int where T: NSManagedObject {
        return (try? viewContext.count(for: request)) ?? 0
    }
    
    func fetch<T>(request: NSFetchRequest<T>) -> [T] where T: NSManagedObject {
        return (try? viewContext.fetch(request)) ?? []
    }
    
    
}
