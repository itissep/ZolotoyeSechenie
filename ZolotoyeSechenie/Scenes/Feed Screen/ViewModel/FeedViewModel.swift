//
//  FeedViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import Foundation
import Combine

class FeedViewModel: NSObject {
    @Published var isLoading: Bool = false
    
    private let productService: ProductServiceDescription
    let coordinator: FeedCoordinatorDescription
    
    let dispatchGroup = DispatchGroup()
    let queue = DispatchQueue(label: "ru.zolotoyesechenie.queue.feed", qos: .background)
    
    @Published var productCellViewModels: [ProductCellViewModel] = []
    @Published var collectionsCellViewModels: [CollectionType: [CollectionCellViewModel]] = [:]
    
    
    init(productService: ProductServiceDescription,
         coordinator: FeedCoordinatorDescription) {
        self.productService = productService
        self.coordinator = coordinator
        super.init()
        
        getProducts()
        dispatchGroup.notify(queue: queue) { [weak self] in
            self?.isLoading = false
        }
    }
    
    func fetchProductsData(_ products: Products) {
        var vms = [ProductCellViewModel]()
        for product in products {
            vms.append(createProductCellModel(with: product))
        }
        productCellViewModels = vms
        dispatchGroup.leave()
    }
    
    
    func fetchCollectionsData(for type: CollectionType, _ collections: [ProductCollection]) {
        var vms = [CollectionCellViewModel]()
        for collection in collections {
            vms.append(createCollectionCellModel(with: collection))
        }
        collectionsCellViewModels[type] = vms
        dispatchGroup.leave()
    }
    
    
    func getProducts() {
        isLoading = true
        
        dispatchGroup.enter()
        productService.getAllProducts(for: nil) {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.dispatchGroup.leave()
            case .success(let products):
                self?.fetchProductsData(products)
            }
        }
        
        
        let collectionTypes: [CollectionType] = [.Programms, .Cosmetics, .Specials]
        for type in collectionTypes {
            dispatchGroup.enter()
            productService.getCollections(for: type) {[weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                    self?.dispatchGroup.leave()
                case .success(let collections):
                    self?.fetchCollectionsData(for: type, collections)
                }
            }
        }
    }
    
    func getCellViewModel(for type: CollectionType, at indexPath: IndexPath) -> CollectionCellViewModel? {
        let index = indexPath.row
        let cellViewModel = collectionsCellViewModels[type]?[index]
        return cellViewModel
    }

    
    func createProductCellModel(with product: Product) -> ProductCellViewModel {
        return ProductCellViewModel(from: product)
    }
    
    func createCollectionCellModel(with collection: ProductCollection) -> CollectionCellViewModel {
        return CollectionCellViewModel(from: collection)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ProductCellViewModel {
        return productCellViewModels[indexPath.row]
    }
    
    // MARK: - Navigation
    
    func goToCollection(type: CollectionType) {
        coordinator.goToCollection(type: type)
    }
}


struct CollectionCellViewModel {
    let id: String
    let title: String
    let imageUrl: String?
    
    init(from model: ProductCollection){
        self.id = model.id
        self.title = model.title
        self.imageUrl = model.imageUrl
    }
    
    #warning("TODO: image loading for collection cell viewModel ???")
}
