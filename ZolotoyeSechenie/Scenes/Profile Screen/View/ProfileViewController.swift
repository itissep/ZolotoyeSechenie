//
//  ProfileViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//


import UIKit
import SnapKit

// TODO: add user category and information about it

class ProfileViewController: UIViewController {
    
    lazy var viewModel = {
        ProfileViewModel()
    }()
    
    let tableView = UITableView()
    let nameLabel = UILabel()
    var countLabel = UILabel()
    let deliveriesBtn = UIButton()
    let favouritesBtn = UIButton()
    
    
    weak var coordinator: ProfileBaseCoordinator?
    
    
    init(coordinator: ProfileBaseCoordinator) {
            super.init(nibName: nil, bundle: nil)
            self.coordinator = coordinator

        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Мой профиль"
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes
        
        initViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupButtons()
        setupTableView()
    }

    func initViewModel() {
        
        viewModel.getData()
        // TODO: not sure if it's ok...
        self.countLabel.text = "\(self.viewModel.deliveriesCount)"
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                
            }
        }
    }
    
    private func setupButtons() {
        
        nameLabel.textColor = K.Colors.darkGold
        // TODO: get name from user defaults via viewModel
        nameLabel.text = "Здравствуйте, \nИван"
        nameLabel.numberOfLines = 2
        nameLabel.font = K.Fonts.semibold30
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
        
        deliveriesBtn.setTitle("Мои доставки", for: .normal)
        deliveriesBtn.addTarget(self, action: #selector(deliveriesBtnPressed), for: .touchUpInside)
        
        deliveriesBtn.backgroundColor = K.Colors.prettyGold
        deliveriesBtn.titleLabel?.font = K.Fonts.semibold20
        deliveriesBtn.titleLabel?.textColor = .white
        deliveriesBtn.layer.cornerRadius = 16
        deliveriesBtn.layer.masksToBounds = true
        deliveriesBtn.contentHorizontalAlignment = .left
        deliveriesBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 10)
        
        deliveriesBtn.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(deliveriesBtn)
        
        deliveriesBtn.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(80)
            make.trailing.equalToSuperview().inset(30)
        }
        
        countLabel.font = K.Fonts.semibold20
        countLabel.textColor = .white
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveriesBtn.addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(35)
        }
                
        favouritesBtn.setTitle("Избранное", for: .normal)
        favouritesBtn.addTarget(self, action: #selector(favouritesBtnPressed), for: .touchUpInside)
        
        favouritesBtn.backgroundColor = K.Colors.prettyGold
        favouritesBtn.titleLabel?.font = K.Fonts.semibold20
        favouritesBtn.titleLabel?.textColor = .white
        favouritesBtn.contentHorizontalAlignment = .left
        favouritesBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 10)
        favouritesBtn.layer.cornerRadius = 16
        favouritesBtn.layer.masksToBounds = true
        
        favouritesBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favouritesBtn)
        
        favouritesBtn.snp.makeConstraints { make in
            make.top.equalTo(deliveriesBtn.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(80)
            make.trailing.equalToSuperview().inset(30)
        }
    }
    
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileSettingsTableCell.self, forCellReuseIdentifier: ProfileSettingsTableCell.identifier)
        tableView.isScrollEnabled = false
        // TODO: remove last separator
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(favouritesBtn.snp.bottom).offset(40)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(30)
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
            let cell = tableView.cellForRow(at: indexPath) as? ProfileSettingsTableCell
        else {
            fatalError("problems with profile settings selections")
        }
        switch cell.cellViewModel?.type {
        case .addresses:
            coordinator?.goToAddresses()
        default:
            print("go somewhere")
        }
        print("selected \(cell.cellViewModel?.type)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
}
