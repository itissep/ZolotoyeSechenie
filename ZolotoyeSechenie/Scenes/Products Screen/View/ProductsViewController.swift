//
//  ProductsViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit
import SnapKit



class ProductsViewController: UIViewController, FeedBaseCoordinated {
    
    lazy var viewModel = {
        ProductsViewModel()
    }()
    
    weak var coordinator: FeedBaseCoordinator?
    
    
    init(coordinator: FeedBaseCoordinator, type: CollectionType) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
//        switch type {
//        case .programm:
//            title = "Какая-то программа"
//        case .all:
//            title = "Все товары"
//        case .cosmetics:
//            title = "Тип косметики"
//        case .specials:
//            title = "Специальные средства"
//        case .favourites:
//            title = "Избранное"
//        }
        title = "\(type)"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let tableView = ProductTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes
        self.tabBarController?.tabBar.isHidden = true
        
        initViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        tableViewSetup()
    }
    
    func initViewModel() {
        viewModel.getProducts()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func tableViewSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}


//MARK: - UITableViewDataSource
extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableCell.identifier, for: indexPath) as? ProductTableCell
        else {
            fatalError("something wrong with order cell")
        }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    
    
}


//MARK: - UITableViewDelegate
extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableCell.identifier, for: indexPath) as? GenericTableCell
        else {
            fatalError("something went wrong with norification selection")
        }
        // TODO: add coordination for notification screen
        print(cell.cellViewModel?.id)
    }
    
}


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
