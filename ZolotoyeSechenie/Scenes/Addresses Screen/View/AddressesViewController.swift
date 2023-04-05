//
//  AddressesViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit
import SnapKit


class AddressesViewController: UIViewController {
    
    lazy var viewModel = {
        AddressesViewModel()
    }()
    
//    weak var coordinator: ProfileBaseCoordinator?
    
    let tableView = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
//        self.coordinator = coordinator
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Адреса"
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes
        
        
        let plusImage = UIImage(named: "Plus")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: plusImage, style: .done, target: self, action: #selector(addTapped))
        
        initViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        tableViewSetup()
    }
    
    func initViewModel() {
//        viewModel.getAddresses()
//        viewModel.reloadTableView = { [weak self] in
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
//        }
    }
    
    private func tableViewSetup(){
//        tableView.delegate = self
//        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        tableView.register(AddressesTableCell.self, forCellReuseIdentifier: AddressesTableCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    @objc
    func addTapped(){
//        coordinator?.goToEditAddress(type: .Add)
    }
}


//MARK: - UITableViewDataSource
//extension AddressesViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.addresses.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard
//            let cell = tableView.dequeueReusableCell(withIdentifier: AddressesTableCell.identifier, for: indexPath) as? AddressesTableCell
//        else {
//            fatalError("something wrong with AddressesTable cell")
//        }
//        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
//        cell.cellViewModel = cellViewModel
//        return cell
//    }
//    
//    
//}


//MARK: - UITableViewDelegate
//extension AddressesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard
//            let cell = tableView.cellForRow(at: indexPath) as? AddressesTableCell
//        else {
//            fatalError("something went wrong with addresses selection")
//        }
//        guard let id = cell.cellViewModel?.id else {
//            return
//        }
////        coordinator?.goToEditAddress(type: .Edit(id))
//    }
//    
//}


