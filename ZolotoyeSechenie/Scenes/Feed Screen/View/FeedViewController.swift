//
//  FeedViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//

// TODO: redo with https://jalpesh-iosdev.medium.com/how-to-create-a-compositional-layout-using-collection-view-in-swift-785a9a886fe9
// pull to refresh
// loader
// skeleton???
//

import SnapKit
import UIKit

class FeedViewController: UIViewController, FeedBaseCoordinated {
    lazy var viewModel = FeedViewModel()
    
    weak var coordinator: FeedBaseCoordinator?

    init(coordinator: FeedBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
        
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView = ProductTableView()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let careProductsLabel = UILabel()
    let specialProductsLabel = UILabel()
    let cosmeticsLabel = UILabel()
    let popularLabel = UILabel()
    
    let caresCollectionView = GenericCollectionView()
    let cosmeticsCollectionView = IconsCollectionView()
    let specialsCollectionView = GenericCollectionView()
    
    let moreBtn = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Лента"
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes
        
        initViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        setupScrollView()
        
        caresCollectionSetup()
        iconsCollectionSetup()
        specialsCollectionSetup()
        
        tableViewSetup()
        moreBtnSetup()
    }
    
    func initViewModel() {
        viewModel.getHeaderData()
        viewModel.reloadHeader = { [weak self] in
            DispatchQueue.main.async {
                self?.caresCollectionView.reloadData()
                self?.cosmeticsCollectionView.reloadData()
                self?.specialsCollectionView.reloadData()
            }
        }
        
        viewModel.getProducts()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc
    func moreBtnPressed() {
        // TODO: go to all products
        coordinator?.goToCollection(type: .all)
        print("moreBtn pressed")
    }
    
    func setupScrollView() {
        view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func caresCollectionSetup() {
        careProductsLabel.text = "Программы ухода"
        careProductsLabel.font = K.Fonts.semibold17
        careProductsLabel.textColor = K.Colors.darkGold
        
        careProductsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(careProductsLabel)
        
        careProductsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().offset(30)
        }
        
        caresCollectionView.delegate = self
        caresCollectionView.dataSource = self
        
        caresCollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(caresCollectionView)
        
        caresCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(careProductsLabel.snp.bottom).offset(15)
            make.height.equalTo(125)
        }
    }
    
    private func iconsCollectionSetup() {
        cosmeticsLabel.text = "Декоративная косметика"
        cosmeticsLabel.font = K.Fonts.semibold17
        cosmeticsLabel.textColor = K.Colors.darkGold
        
        cosmeticsLabel.translatesAutoresizingMaskIntoConstraints = true
        contentView.addSubview(cosmeticsLabel)
        
        cosmeticsLabel.snp.makeConstraints { make in
            make.top.equalTo(caresCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(30)
        }
        
        cosmeticsCollectionView.delegate = self
        cosmeticsCollectionView.dataSource = self
        
        cosmeticsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cosmeticsCollectionView)
        
        cosmeticsCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(cosmeticsLabel.snp.bottom).offset(15)
            make.height.equalTo(63)
        }
    }
    
    private func specialsCollectionSetup() {
        specialProductsLabel.text = "Специальные средства"
        specialProductsLabel.font = K.Fonts.semibold17
        specialProductsLabel.textColor = K.Colors.darkGold
        
        specialProductsLabel.translatesAutoresizingMaskIntoConstraints = true
        contentView.addSubview(specialProductsLabel)
        specialProductsLabel.snp.makeConstraints { make in
            make.top.equalTo(cosmeticsCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(30)
        }
        
        specialsCollectionView.delegate = self
        specialsCollectionView.dataSource = self
        
        specialsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(specialsCollectionView)
        
        specialsCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(specialProductsLabel.snp.bottom).offset(15)
            make.height.equalTo(125)
        }
    }
    
    private func tableViewSetup() {
        popularLabel.text = "Популярное"
        popularLabel.font = K.Fonts.semibold20
        popularLabel.textColor = K.Colors.darkGold
        
        popularLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(popularLabel)
        
        popularLabel.snp.makeConstraints { make in
            make.top.equalTo(specialsCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(30)
        }
        
        tableView.isScrollEnabled = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(popularLabel.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.height.equalTo(660)
        }
    }
    
    private func moreBtnSetup() {
        moreBtn.addTarget(self, action: #selector(moreBtnPressed), for: .touchUpInside)
        
        moreBtn.setTitle("Все продукты", for: .normal)
        moreBtn.titleLabel?.font = K.Fonts.semibold17
        moreBtn.backgroundColor = K.Colors.prettyGold
        moreBtn.layer.masksToBounds = false
        moreBtn.layer.cornerRadius = 16
        
        moreBtn.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(moreBtn)
        
        moreBtn.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}

// MARK: - UITableViewDelegate

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ProductTableCell else {
            fatalError("some problems with product cells")
        }
        // TODO: open product page
        print(cell.cellViewModel?.id)
    }
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.productCellViewModels.count
        if count >= 5 {
            return 5
        } else {
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableCell.identifier, for: indexPath) as? ProductTableCell
        else {
            fatalError("xib does not exists")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.caresCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? GenericCollectionCell else {
                // TODO: add error handler
                fatalError("something went wrong tapping on Cares Collection cells")
            }
            print(cell.cellViewModel?.id)
            coordinator?.goToCollection(type: .Programms)
        } else if collectionView == self.cosmeticsCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? IconCollectionViewCell else {
                // TODO: add error handler
                fatalError("something went wrong tapping on Cosmetics Collection cells")
            }
            print(cell.cellViewModel?.id)
            coordinator?.goToCollection(type: .Cosmetics)
        } else if collectionView == self.specialsCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? GenericCollectionCell else {
                // TODO: add error handler
                fatalError("something went wrong tapping on Cares Collection cells")
            }
            print(cell.cellViewModel?.id)
            coordinator?.goToCollection(type: .Specials)
        } else {
            fatalError("Some spiritual collection view was detected. Do something!")
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cosmeticsCollectionView {
            return viewModel.headerViewModel.cosmeticCategories.count
        } else if collectionView == self.caresCollectionView {
            return viewModel.headerViewModel.careProgramms.count
        } else if collectionView == self.specialsCollectionView {
            return viewModel.headerViewModel.specialProducts.count
        } else {
            fatalError("Some spiritual collection view was detected. Do something!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.caresCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionCell.identifier, for: indexPath) as? GenericCollectionCell else {
                fatalError("something went wrong with Cares Collection cells")
            }
            
            let cellViewModel = viewModel.getCareCellViewModel(at: indexPath)
            cell.cellViewModel = cellViewModel
            return cell
        } else if collectionView == self.cosmeticsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCollectionViewCell.identifier, for: indexPath) as? IconCollectionViewCell else {
                fatalError("something went wrong with Cares Collection cells")
            }
            
            let cellViewModel = viewModel.getCosmeticsCellViewModel(at: indexPath)
            cell.cellViewModel = cellViewModel
            return cell
        } else if collectionView == self.specialsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionCell.identifier, for: indexPath) as? GenericCollectionCell else {
                fatalError("something went wrong with Special Collection cells")
            }
            
            let cellViewModel = viewModel.getSpecialsCellViewModel(at: indexPath)
            cell.cellViewModel = cellViewModel
            return cell
        } else {
            fatalError("Some spiritual collection view was detected. Do something!")
        }
    }
}
