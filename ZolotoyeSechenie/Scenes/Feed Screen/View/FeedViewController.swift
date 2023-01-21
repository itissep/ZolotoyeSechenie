//
//  FeedViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//

import UIKit


class FeedViewController: UIViewController {
    
    lazy var viewModel = {
            ProductsViewModel()
        }()
    
    let tableView = UITableView()

        override func viewDidLoad() {
            super.viewDidLoad()
            initView()
            initViewModel()
        }

        func initView() {
            // TableView customization
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = .white
            tableView.separatorColor = .white
            tableView.separatorStyle = .singleLine
            tableView.tableFooterView = UIView()
            tableView.allowsSelection = false

            tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableView)
            NSLayoutConstraint.activate([
                tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
                tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            ])

        }

    func initViewModel() {
            viewModel.getProducts()
            viewModel.reloadTableView = { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
}




// MARK: - UITableViewDelegate

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.text = "Notification Times"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .green
            
            headerView.addSubview(label)
            
            return headerView
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}
