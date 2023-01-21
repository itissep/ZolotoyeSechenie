//
//  ProductCell.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import UIKit


class ProductTableCell: UITableViewCell {
    let coverImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let amountLabel = UILabel()
    let priceLabel = UILabel()


    
    class var identifier: String { return String(describing: self) }
    
    var cellViewModel: ProductCellViewModel? {
        didSet {
            titleLabel.text = cellViewModel?.title
            descriptionLabel.text = cellViewModel?.description
            amountLabel.text = cellViewModel?.amount
            priceLabel.text = cellViewModel?.price
            
            // TODO: Proper Image Setter
            coverImageView.image = UIImage(named: cellViewModel?.image ?? "2")
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
        // Cell view customization
        contentView.backgroundColor = .white
        
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.contentMode = .scaleAspectFill
        
        coverImageView.layer.masksToBounds = true
        coverImageView.layer.cornerRadius = 16
        
        contentView.addSubview(coverImageView)
        
        coverImageView.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(120)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().inset(6)
            make.leading.equalToSuperview().offset(30)
        }
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = true
        priceLabel.textColor = .black
        priceLabel.font = K.Fonts.medium20
        priceLabel.textAlignment = .right
        
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(6)
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = K.Fonts.semibold20
        titleLabel.textColor = K.Colors.darkGold
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalTo(priceLabel.snp.leading).inset(6)
        }
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = K.Fonts.regular15
        descriptionLabel.textColor = .black
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalTo(priceLabel.snp.leading).inset(6)
        }
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.textColor = .gray
        amountLabel.font = K.Fonts.semibold15
        
        contentView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalTo(priceLabel.snp.leading).inset(6)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        coverImageView.image = nil
    }
}




