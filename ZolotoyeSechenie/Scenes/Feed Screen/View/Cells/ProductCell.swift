//
//  ProductCell.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import UIKit


class ProductCell: UITableViewCell {
    let idLabel = UILabel()

    
    class var identifier: String { return String(describing: self) }
    
    var cellViewModel: ProductCellViewModel? {
        didSet {
            idLabel.text = cellViewModel?.id
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
        contentView.backgroundColor = .yellow
        
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(idLabel)
        idLabel.textColor = .black
        // idLabel constraints
        NSLayoutConstraint.activate([
            idLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            idLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            idLabel.widthAnchor.constraint(equalToConstant: 100),
            idLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        idLabel.text = nil

    }
}




