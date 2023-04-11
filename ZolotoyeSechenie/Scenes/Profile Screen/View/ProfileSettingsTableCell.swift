//
//  ProfileTableCell.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import UIKit

class ProfileSettingsTableCell: UITableViewCell {
    private lazy var coverImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    
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
        
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    public func configure(with model: SettingsCellViewModel) {
        titleLabel.text = model.title
        coverImageView.image = model.image
    }
    
    public func removeSeparator(_ isRemoved: Bool) {
        if isRemoved {
            self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
    }
}

