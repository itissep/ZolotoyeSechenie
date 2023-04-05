//
//  OrderViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit
import SnapKit


class OrdersViewController: UIViewController {
    
    lazy var viewModel = {
        OrdersViewModel()
    }()
    
//    weak var coordinator: ProfileBaseCoordinator?
    
    
//    init(coordinator: ProfileBaseCoordinator, type: OrdersType) {
    init() {
        super.init(nibName: nil, bundle: nil)
//        self.coordinator = coordinator
//        switch type {
//        case .history:
//            title = "История заказов"
//        case .deliveries:
//            title = "Текущие доставки"
//        }
//        self.title = title
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let tableView = GenericTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes
        self.tabBarController?.tabBar.isHidden = true
        
        initViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        tableViewSetup()
    }
    
    func initViewModel() {
        viewModel.getOrders()
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
extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableCell.identifier, for: indexPath) as? GenericTableCell
        else {
            fatalError("something wrong with order cell")
        }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    
    
}


//MARK: - UITableViewDelegate
extension OrdersViewController: UITableViewDelegate {
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
