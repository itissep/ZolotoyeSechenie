//
//  ProfileViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//


import UIKit
import SnapKit
import Combine
#warning("TODO: view reload")
#warning("TODO: add user category and information about it")

class ProfileViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    private lazy var nameLabel = UILabel()
    private lazy var countLabel = UILabel()
    private lazy var deliveriesBtn = UIButton()
    private lazy var favouritesBtn = UIButton()
    private lazy var loadingView = LoadingView(withBackground: true)
    
    private let viewModel: ProfileViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Профиль"
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes
        
        
        setupBinding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupButtons()
        setupTableView()
        
        loadingView.frame = view.frame
        view.addSubview(loadingView)
    }
    
    private func setupBinding() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isLoading in
                if isLoading {
                    self?.loadingView.startLoading()
                } else {
                    self?.countLabel.text = "\(self?.viewModel.deliveriesCount ?? 0)"
                    self?.configureNameLabel()
                    self?.loadingView.endLoading()
                }
            }
            .store(in: &subscriptions)
    }
    
    private func configureNameLabel() {
        guard let name = viewModel.userInfo?.name else { return }
        nameLabel.text = "Здравствуйте, \n\(name)"
    }
    
    private func setupButtons() {
        
        nameLabel.textColor = K.Colors.darkGold
        nameLabel.numberOfLines = 2
        nameLabel.font = K.Fonts.semibold30
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalToSuperview().offset(K.hPadding)
            make.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        deliveriesBtn.setTitle("Мои доставки", for: .normal)
        deliveriesBtn.addTarget(self, action: #selector(deliveriesBtnPressed), for: .touchUpInside)
        
        deliveriesBtn.backgroundColor = K.Colors.prettyGold
        deliveriesBtn.titleLabel?.font = K.Fonts.semibold20
        deliveriesBtn.titleLabel?.textColor = .white
        deliveriesBtn.layer.cornerRadius = K.cornerRadius
        deliveriesBtn.layer.masksToBounds = true
        deliveriesBtn.contentHorizontalAlignment = .left
        deliveriesBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 10)
        
        deliveriesBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deliveriesBtn)
        
        deliveriesBtn.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(K.hPadding)
            make.height.equalTo(80)
            make.trailing.equalToSuperview().inset(K.hPadding)
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
        favouritesBtn.layer.cornerRadius = K.cornerRadius
        favouritesBtn.layer.masksToBounds = true
        
        favouritesBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favouritesBtn)
        
        favouritesBtn.snp.makeConstraints { make in
            make.top.equalTo(deliveriesBtn.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(K.hPadding)
            make.height.equalTo(80)
            make.trailing.equalToSuperview().inset(K.hPadding)
        }
    }
    
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileSettingsTableCell.self, forCellReuseIdentifier: ProfileSettingsTableCell.identifier)
        tableView.isScrollEnabled = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(favouritesBtn.snp.bottom).offset(40)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(K.hPadding)
            make.bottom.equalToSuperview()
        }
    }
    
    private func showDeleteProfileAlert(){
        let alert = UIAlertController.createAlert(
            withTitle: "Хотите удалить профиль?",
            message: "Это дейстивие нельзя отменить. Ваш аккаунт будет удален.",
            buttonString: "Удалить") {[weak self] _ in
                self?.viewModel.deleteProfileWasPressed()
            }
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showSignOutAlert(){
        let alert = UIAlertController.createAlert(
            withTitle: "Хотите выйти из профиля?",
            message: "Всегда сможете к нам вернуться.",
            buttonString: "Выйти") {[weak self] _ in
                self?.viewModel.sighOutWasPressed()
            }
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    func deliveriesBtnPressed(){
#warning("TODO: coordinator?.goToDeliveries()")
    }
    
    @objc
    func favouritesBtnPressed(){
        #warning("TODO: coordinator?.goToFavourites()")
    }
}


//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsTableCell.identifier, for: indexPath)
        guard
            let cell = cell as? ProfileSettingsTableCell
        else {
            fatalError("something wrong with profile settings cell")
        }
        let cellViewModel = viewModel.settingsViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        let isLast = indexPath.row == viewModel.settingsViewModels.count - 1
        cell.removeSeparator(isLast)
        
        return cell
    }
}


//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = viewModel.settingsViewModels[indexPath.row].type
        
        switch type {
        case .addresses, .history:
            viewModel.goToScreen(for: type)
        case .deleteProfile:
            self.showDeleteProfileAlert()
        case .signOut:
            self.showSignOutAlert()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
}
