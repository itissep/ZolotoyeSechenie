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
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Адреса"
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes

        
        initViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        tableViewSetup()
    }
    
    func initViewModel() {
        viewModel.getAddresses()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func tableViewSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}


//MARK: - UITableViewDataSource
extension AddressesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: AddressesTableCell.identifier, for: indexPath) as? AddressesTableCell
        else {
            fatalError("something wrong with AddressesTable cell")
        }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    
    
}


//MARK: - UITableViewDelegate
extension AddressesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: AddressesTableCell.identifier, for: indexPath) as? AddressesTableCell
        else {
            fatalError("something went wrong with addresses selection")
        }
        // TODO: add coordination for address screen
        print(cell.cellViewModel?.id)
    }
    
}


class AddressesTableCell: UITableViewCell {
    
    let coverImageView = UIImageView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let dateLabel = UILabel()
    
    class var identifier: String { return String(describing: self) }
    
    var cellViewModel: AddressCellViewModel? {
        didSet {
            titleLabel.text = cellViewModel?.title
            messageLabel.text = cellViewModel?.message
            dateLabel.text = cellViewModel?.index
            
            // TODO: Proper Image Setter
            coverImageView.image = UIImage(named: "whiteHouse")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initView() {
        contentView.backgroundColor = .white
        
        var imageView : UIImageView
                imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                imageView.image = UIImage(named:"Disclosure Indicator")
                self.accessoryView = imageView

    
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.layer.masksToBounds = true
        coverImageView.layer.cornerRadius = 16
        
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coverImageView)
        
        coverImageView.snp.makeConstraints { make in
            make.width.equalTo(51)
            make.height.equalTo(51)
            make.top.equalToSuperview().offset(6)
            make.leading.equalToSuperview().offset(30)
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.font = K.Fonts.medium17
        titleLabel.textColor = K.Colors.darkGold
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(30)
        }
        
        messageLabel.font = K.Fonts.regular15
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(30)
        }
        
        dateLabel.textColor = .gray
        dateLabel.font = K.Fonts.semibold15
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(4)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(6)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        coverImageView.image = nil
    }
}


