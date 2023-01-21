//
//  FeedViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//


// TODO: redo with https://jalpesh-iosdev.medium.com/how-to-create-a-compositional-layout-using-collection-view-in-swift-785a9a886fe9
import UIKit
import SnapKit


class FeedViewController: UIViewController {
    
    lazy var viewModel = {
        ProductsViewModel()
    }()
    
    let tableView = UITableView()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let careProductsLabel = UILabel()
    let specialProductsLabel = UILabel()
    let cosmeticsLabel = UILabel()
    
    //    lazy var collectionView: UICollectionView = {
    //
    //            let layout = UICollectionViewFlowLayout()
    //            layout.scrollDirection = .horizontal
    //            layout.itemSize = CGSize(width: 213, height: 125)
    //            layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    //            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    //
    //            collectionView.register(GenericCollectionViewCell.self, forCellWithReuseIdentifier: GenericCollectionViewCell.identifier)
    //
    //            collectionView.showsHorizontalScrollIndicator = false
    //            collectionView.backgroundColor = .white
    //            return collectionView
    //        }()
    
    let caresCollectionView = GenericCollectionView()
    let cosmeticsCollectionView = IconsCollectionView()
    let specialsCollectionView = GenericCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupViews()
        initView()
        initViewModel()
    }
    
    func initView() {
        print("tableview setup")
        // TableView customization
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .green
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //        contentView.addSubview(tableView)
        //        NSLayoutConstraint.activate([
        //            tableView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        //            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
        //            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        //
        //            tableView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        //            tableView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        //        ])
        
    }
    
    func setupScrollView(){
        view.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .white
        
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
    }
    
    func setupViews(){
        
        careProductsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(careProductsLabel)
        careProductsLabel.text = "Программы ухода"
        careProductsLabel.font = K.Fonts.semibold17
        careProductsLabel.textColor = K.Colors.darkGold
        
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
            //            make.bottom.equalToSuperview()
            make.height.equalTo(125)
        }
        
        cosmeticsLabel.translatesAutoresizingMaskIntoConstraints = true
        contentView.addSubview(cosmeticsLabel)
        cosmeticsLabel.text = "Декоративная косметика"
        cosmeticsLabel.font = K.Fonts.semibold17
        cosmeticsLabel.textColor = K.Colors.darkGold
        
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
        
        specialProductsLabel.translatesAutoresizingMaskIntoConstraints = true
        contentView.addSubview(specialProductsLabel)
        specialProductsLabel.text = "Специальные средства"
        specialProductsLabel.font = K.Fonts.semibold17
        specialProductsLabel.textColor = K.Colors.darkGold
        
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
            make.bottom.equalToSuperview()
            
        }
        
    }
    
    func initViewModel() {
        viewModel.getHeaderData()
        viewModel.reloadHeader = { [weak self] in
            DispatchQueue.main.async {
                self?.caresCollectionView.reloadData()
                self?.cosmeticsCollectionView.reloadData()
                self?.specialsCollectionView.reloadData()
                // TODO: reload other collection views
            }
            
        }
        
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



//MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.caresCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? GenericCollectionCell else {
                // TODO: add error handler
                fatalError("something went wrong tapping on Cares Collection cells")
            }
            print(cell.cellViewModel?.id)
        } else if collectionView == self.cosmeticsCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? IconCollectionViewCell else {
                // TODO: add error handler
                fatalError("something went wrong tapping on Cosmetics Collection cells")
            }
            print(cell.cellViewModel?.id)
        } else if collectionView == self.specialsCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? GenericCollectionCell else {
                // TODO: add error handler
                fatalError("something went wrong tapping on Cares Collection cells")
            }
            print(cell.cellViewModel?.id)
        } else {
            fatalError("Some spiritual collection view was detected. Do something!")
        }
        
    }
}

//MARK: - UICollectionViewDataSource
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







