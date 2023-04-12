//
//  AddressesViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit
import SnapKit
import Combine

class AddressesViewController: UIViewController {
    private lazy var tableView = UITableView()
    private lazy var loadingView = LoadingView()
    private lazy var refreshControl = UIRefreshControl()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let viewModel: AddressesViewModel
    
    // MARK: - Life Cycle
    
    init(viewModel: AddressesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navbarSetup()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    override func viewDidLayoutSubviews() {
        tableViewSetup()
        
        loadingView.frame = view.frame
        view.addSubview(loadingView)
    }
    
    // MARK: - Binding to viewModel
    
    func initViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isLoading in
                if isLoading {
                    self?.loadingView.startLoading()
                } else {
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                    self?.loadingView.endLoading()
                }
            }
            .store(in: &subscriptions)
        
        viewModel.$addressCellViewModels
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Navbar Setup
    
    private func navbarSetup() {
        title = "Адреса"
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes
        
        
        let plusImage = UIImage(named: "Plus")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: plusImage, style: .done, target: self, action: #selector(addTapped))
    }
    
    // MARK: - TableView Setup
    
    private func tableViewSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = K.Colors.prettyGold
        tableView.refreshControl = refreshControl
        
        tableView.register(AddressesTableCell.self, forCellReuseIdentifier: AddressesTableCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Selectors
    
    @objc
    func refresh() {
        viewModel.reload()
    }
    
    @objc
    func addTapped(){
        viewModel.goToAddress(.Add)
    }
}

//MARK: - UITableViewDataSource

extension AddressesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.addressCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: AddressesTableCell.identifier, for: indexPath) as? AddressesTableCell
        else {
            fatalError("something wrong with AddressesTable cell")
        }
        let cellViewModel = viewModel.addressCellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        return cell
    }
}


//MARK: - UITableViewDelegate

extension AddressesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addressId = viewModel.addressCellViewModels[indexPath.row].id
        viewModel.goToAddress(.Edit(addressId))
    }
}
