//
//  NotificationsViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//

import UIKit
import Combine
import SnapKit

class NotificationsViewController: UIViewController {
    private lazy var tableView = GenericTableView()
    private lazy var loadingView = LoadingView(withBackground: true)
    private lazy var refreshControl = UIRefreshControl()
    
    private let viewModel: NotificationsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life Cycle
    
    init(viewModel: NotificationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNavBar()
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    // MARK: - viewModel Binding
    
    private func bindViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isLoading in
                if isLoading {
                    self?.loadingView.startLoading()
                } else {
                    self?.loadingView.endLoading()
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &subscriptions)
        
        viewModel.$notificationCellViewModels
            .receive(on: DispatchQueue.main)
            .print()
            .sink {[weak self] _ in
                self?.tableView.reloadData()
                
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - UI
    
    private func setupNavBar() {
        title = "Уведомления"
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes
    }
    
    private func layout() {
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = K.Colors.prettyGold
        tableView.refreshControl = refreshControl
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(loadingView)
        loadingView.frame = view.frame
    }
    
    // MARK: - Selectors
    
    @objc
    private func refresh() {
        viewModel.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notificationCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableCell.identifier, for: indexPath) as? GenericTableCell
        else {
            fatalError("something wrong with notification cell")
        }
        let cellViewModel = viewModel.notificationCellViewModels[indexPath.row]
        #warning("TODO: redo with configuration")
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
