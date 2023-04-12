//
//  GenericTableCell.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import SnapKit
import UIKit

protocol GenericCellViewModelProtocol {
    var id: String { get }
    var title: String { get }
    var message: String { get }
    var date: Date { get }
    var image: String? { get }
}

class GenericTableCell: UITableViewCell {
    let coverImageView = UIImageView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let dateLabel = UILabel()
    
    class var identifier: String { return String(describing: self) }
    
    var cellViewModel: GenericCellViewModelProtocol? {
        didSet {
            titleLabel.text = cellViewModel?.title
            messageLabel.text = cellViewModel?.message
            dateLabel.text = "\(cellViewModel?.date)"
            
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
        contentView.backgroundColor = .white
        
        self.selectionStyle = .none
        
        var imageView: UIImageView
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.image = UIImage(named: "Disclosure Indicator")
        self.accessoryView = imageView

        coverImageView.contentMode = .scaleAspectFill
        coverImageView.layer.masksToBounds = true
        coverImageView.layer.cornerRadius = K.cornerRadius
        
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coverImageView)
        
        coverImageView.snp.makeConstraints { make in
            make.width.equalTo(51)
            make.height.equalTo(51)
            make.top.equalToSuperview().offset(6)
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
        
        messageLabel.font = K.Fonts.regular15
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        dateLabel.textColor = .gray
        dateLabel.font = K.Fonts.semibold15
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(4)
            make.leading.equalTo(coverImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(K.hPadding)
            make.bottom.equalToSuperview().inset(6)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        coverImageView.image = nil
    }
}

