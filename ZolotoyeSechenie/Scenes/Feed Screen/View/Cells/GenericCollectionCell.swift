//
//  CaresCell.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import UIKit
import SnapKit


class GenericCollectionCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let coverImageView = UIImageView()
    let opacityView = UIView()
    
    class var identifier: String { return String(describing: self) }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.backgroundColor = K.Colors.darkGold
        coverImageView.layer.masksToBounds = true
        coverImageView.layer.cornerRadius = K.cornerRadius
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = K.Fonts.semibold20
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        opacityView.translatesAutoresizingMaskIntoConstraints = false
        opacityView.backgroundColor = K.Colors.darkGold
        opacityView.alpha = 0.6
        opacityView.layer.masksToBounds = true
        opacityView.layer.cornerRadius = K.cornerRadius
        
        contentView.addSubview(coverImageView)
        contentView.addSubview(opacityView)
        contentView.addSubview(titleLabel)
        
        coverImageView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(contentView)
        }
        
        opacityView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    public func configure(with model: CollectionCellViewModel){
        titleLabel.text = model.title
        #warning("TODO: add loader for imageUrl")
        coverImageView.image = UIImage.placeholder()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
    }
    
}


