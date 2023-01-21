//
//  ProductViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import Foundation


class ProductsViewModel: NSObject {
    private var productService: ProductsServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var products = Products()
    
    var productCellViewModels = [ProductCellViewModel]() {
        didSet {
            reloadTableView?()
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
    
    init(productService: ProductsServiceProtocol = ProductsService()) {
        self.productService = productService
        
        // ...
        
    }
    
    
    func getProducts() {
        productService.getEmployees { success, model, error in
            if success, let products = model {
                self.fetchData(products: products)
            } else {
                print(error!)
            }
        }
    }
    
    
    func createCellModel(product: Product) -> ProductCellViewModel {
        let id = product.id
        
        return ProductCellViewModel(id: id)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ProductCellViewModel {
        return productCellViewModels[indexPath.row]
    }
    
    
    
}
