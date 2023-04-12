//
//  RadioView.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 12.04.2023.
//

import Foundation
import UIKit
import SnapKit

final class RadioTableCell: UITableViewCell {
    private lazy var innerView = UIView()
    private lazy var captureLabel = UILabel()
    private lazy var iconImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var radioImageView = UIImageView()
    
    private var id: String?
    
    class var identifier: String { return String(describing: self) }
    
    var isChecked = false {
        didSet {
            ratioSetup(isChecked)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = .none
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout() {
        self.addSubviews([innerView, captureLabel])
        innerView.addSubviews([iconImageView, titleLabel, radioImageView])
    
        innerView.layer.cornerRadius = K.cornerRadius
        innerView.layer.masksToBounds = true
        innerView.backgroundColor = K.Colors.prettyGold.withAlphaComponent(0.2)
        innerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.top.equalToSuperview()
            make.height.equalTo(64)
        }
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(K.hPadding)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(40)
        }
        
        titleLabel.font = K.Fonts.regular15
        titleLabel.textColor = K.Colors.darkGold
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
        
        radioImageView.contentMode = .scaleAspectFit
        radioImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        captureLabel.numberOfLines = 0
        captureLabel.textColor = K.Colors.darkGold.withAlphaComponent(0.5)
        captureLabel.font = K.Fonts.regular13
        captureLabel.snp.makeConstraints { make in
            make.leading.equalTo(innerView.snp.leading).inset(K.hPadding)
            make.trailing.equalTo(innerView.snp.trailing).inset(K.hPadding)
            
//            make.leading.trailing.equalToSuperview().inset(K.hPadding) // to background with insets
            make.top.equalTo(innerView.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func ratioSetup(_ isChecked: Bool) {
        if isChecked {
            radioImageView.image = UIImage.systemWithConfig(name: "circle.inset.filled", size: 30)
        } else {
            radioImageView.image = UIImage.systemWithConfig(name: "circle", size: 30)
        }
    }
    
    public func configure(with model: RadioViewModel) {
        id = model.id
        titleLabel.text = model.title
        captureLabel.text = model.capture
        iconImageView.image = model.image
        isChecked = model.isChecked
    }
    
    @objc
    func toggle() {
//        delegate?.wasSelectedItem(at: index, with: id)
        isChecked.toggle()
    }
}


final class RadioViewModel {
    let id: String
    let title: String
    let capture: String?
    let image: UIImage?
    let isChecked: Bool
    
    init(id: String, title: String, capture: String?, image: UIImage?, isChecked: Bool) {
        self.id = id
        self.title = title
        self.capture = capture
        self.image = image
        self.isChecked = isChecked
    }
}
