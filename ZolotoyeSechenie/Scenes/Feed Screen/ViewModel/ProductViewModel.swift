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
    var reloadHeader: (() -> Void)?
    
    var products = Products()
    
    var cares = [MockData.CareProgramms]()
    var cosmetics = [MockData.DecorativeCategories]()
    var specials = [MockData.SpecialProducts]()
    
    
    var productCellViewModels = [ProductCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    
    // TODO: get rid of it
    var headerViewModel = FeedHeaderViewModel(){
        didSet {
            reloadHeader?()
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
        
    }
    
    
    func getProducts() {
        productService.getProducts { success, model, error in
            if success, let products = model {
                self.fetchData(products: products)
            } else {
                print(error!)
            }
        }
    }
    
    
    func getHeaderData() {
        // TODO: change to json getter later
        
        let cares = MockData.CareProgramms.all
        let specials = MockData.SpecialProducts.all
        let cosmetics = MockData.DecorativeCategories.all
        
        self.headerViewModel = FeedHeaderViewModel(careProgramms: cares, cosmeticCategories: cosmetics, specialProducts: specials)
    }
    
    
    func createCellModel(product: Product) -> ProductCellViewModel {
        let id = product.id
        // TODO: change data later
        return ProductCellViewModel(id: id) // change properties
    }
    
    
    func getCellViewModel(at indexPath: IndexPath) -> ProductCellViewModel {
        return productCellViewModels[indexPath.row]
    }
    
    func getCareCellViewModel(at indexPath: IndexPath) -> MockData.CareProgramms {
        return headerViewModel.careProgramms[indexPath.row]
    }
    
    func getCosmeticsCellViewModel(at indexPath: IndexPath) -> MockData.DecorativeCategories {
        return headerViewModel.cosmeticCategories[indexPath.row]
    }
    
    func getSpecialsCellViewModel(at indexPath: IndexPath) -> MockData.SpecialProducts {
        return headerViewModel.specialProducts[indexPath.row]
    }
    
    
    
}
