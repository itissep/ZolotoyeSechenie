//
//  ProfileTableCell.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import UIKit


class ProfileSettingsTableCell: UITableViewCell {
    let coverImageView = UIImageView()
    let titleLabel = UILabel()
    
    class var identifier: String { return String(describing: self) }
    
    var cellViewModel: SettingsCellViewModel? {
        didSet {
            titleLabel.text = cellViewModel?.title
            // TODO: Proper Image Setter
            coverImageView.image = cellViewModel?.image
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
//        coverImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(coverImageView)
        
        coverImageView.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().inset(6)
            make.leading.equalToSuperview().offset(K.hPadding)
        }
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = K.Fonts.medium15
        titleLabel.textColor = K.Colors.darkGold
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(K.hPadding)
            
        }
        
    }
}

