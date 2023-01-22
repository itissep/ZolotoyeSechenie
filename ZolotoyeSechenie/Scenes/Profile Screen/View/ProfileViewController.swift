//
//  ProfileViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//
// TODO: add user category and information about it


import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    lazy var viewModel = {
        ProfileViewModel()
    }()
    
    let tableView = UITableView()
    let nameLabel = UILabel()
    var countLabel = UILabel()
    let deliveriesBtn = UIButton()
    let favouritesBtn = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Мой профиль"
        
        initViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupButtons()
        setupTableView()
    }

    func initViewModel() {
        
        viewModel.getData()
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.countLabel.text = "\(self?.viewModel.deliveriesCount)"
            }
        }
    }
    
    private func setupButtons() {
        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileSettingsTableCell.self, forCellReuseIdentifier: ProfileSettingsTableCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    @objc
    func deliveriesBtnPressed(){
        print("go to deliveries")
    }
    
    @objc
    func favouritesBtnPressed(){
        print("go to favourites")
    }
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.settingsViewModels.count)
        return viewModel.settingsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsTableCell.identifier, for: indexPath) as? ProfileSettingsTableCell
        else {
            fatalError("something wrong with profile settings cell")
        }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        
        return cell
    }
}


//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsTableCell.identifier, for: indexPath) as? ProfileSettingsTableCell
        else {
            fatalError("problems with profile settings selections")
        }
//        switch cell.cellViewModel?.type {
//        case .addresses:
//            <#code#>
//        default:
//            <#code#>
//        }
        print("selected \(cell.cellViewModel?.type.rawValue)")
    }
}
