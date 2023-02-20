//
//  NotificationsViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//

import SnapKit
import UIKit

class NotificationsViewController: UIViewController, NotificationsBaseCoordinated {
    lazy var viewModel = NotificationsViewModel()
    
    weak var coordinator: NotificationsBaseCoordinator?
    
    init(coordinator: NotificationsBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView = GenericTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Уведомления"
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes

        initViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        tableViewSetup()
    }
    
    func initViewModel() {
        viewModel.getNotifications()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func tableViewSetup() {
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

// MARK: - UITableViewDataSource

extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableCell.identifier, for: indexPath) as? GenericTableCell
        else {
            fatalError("something wrong with notification cell")
        }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NotificationsViewController: UITableViewDelegate {
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
