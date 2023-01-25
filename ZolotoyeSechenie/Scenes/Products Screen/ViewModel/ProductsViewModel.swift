//
//  ProductsViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 24.01.2023.
//

import Foundation

class ProductsViewModel: NSObject {
    
    private var productsService: ProductsServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var products = Products()
    
    var productCellViewModels = [ProductCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(productsService: ProductsServiceProtocol = ProductsService()) {
        self.productsService = productsService
    }
    
    func getProducts() {
        productsService.getProducts { success, model, error in
            if success, let products = model {
                self.fetchData(products: products)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(products: Products) {
        self.products = products // Cache
        var vms = [ProductCellViewModel]()
        for product in products {
            vms.append(createCellModel(product: product))
        }
        productCellViewModels = vms
    }
    
    func createCellModel(product: Product) -> ProductCellViewModel {
        let id = product.id
        // TODO: change data later
        return ProductCellViewModel(id: id) // change properties
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ProductCellViewModel {
        return productCellViewModels[indexPath.row]
    }
}
