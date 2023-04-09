//
//  AddressTableCell.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import UIKit


class AddressesTableCell: UITableViewCell {
    
    private lazy var coverImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var cityLabel = UILabel()
    private lazy var indexLabel = UILabel()
    
    class var identifier: String { return String(describing: self) }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout() {
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
            make.leading.equalToSuperview().offset(K.hPadding)
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.font = K.Fonts.medium17
        titleLabel.textColor = K.Colors.darkGold
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        cityLabel.font = K.Fonts.regular15
        cityLabel.textColor = .black
        cityLabel.numberOfLines = 0
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cityLabel)
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        indexLabel.textColor = .gray
        indexLabel.font = K.Fonts.semibold15
        
        indexLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(indexLabel)
        
        indexLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(4)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(K.hPadding)
            make.bottom.equalToSuperview().inset(6)
        }
    }
    
    func configure(with model: AddressCellViewModel) {
        indexLabel.text = model.index
        titleLabel.text = model.title
        cityLabel.text = model.message
    }
}


