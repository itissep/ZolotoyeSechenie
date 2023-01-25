//
//  AddressTableCell.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit


class AddressesTableCell: UITableViewCell {
    
    let coverImageView = UIImageView()
    let titleLabel = UILabel()
    let cityLabel = UILabel()
    let indexLabel = UILabel()
    
    class var identifier: String { return String(describing: self) }
    
    var cellViewModel: AddressCellViewModel? {
        didSet {
            titleLabel.text = cellViewModel?.title
            cityLabel.text = cellViewModel?.message
            indexLabel.text = cellViewModel?.index
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
        self.selectionStyle = .none
        
        var imageView : UIImageView
        imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.image = UIImage(named:"Disclosure Indicator")
        self.accessoryView = imageView
        
        coverImageView.layer.masksToBounds = true
        coverImageView.layer.cornerRadius = 51/2
        coverImageView.backgroundColor = K.Colors.prettyGold
        
        let houseIcon = UIImage(systemName: "house.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        coverImageView.contentMode = .center
        coverImageView.preferredSymbolConfiguration = .init(pointSize: 23)
        coverImageView.image = houseIcon
        
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coverImageView)
        
        coverImageView.snp.makeConstraints { make in
            make.width.equalTo(51)
            make.height.equalTo(51)
            make.centerY.equalToSuperview()
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
        
        cityLabel.font = K.Fonts.regular15
        cityLabel.textColor = .black
        cityLabel.numberOfLines = 0
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cityLabel)
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(30)
        }
        
        indexLabel.textColor = .gray
        indexLabel.font = K.Fonts.semibold15
        
        indexLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(indexLabel)
        
        indexLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(4)
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


