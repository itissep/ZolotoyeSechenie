//
//  IconCollectionCell.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import UIKit
import SnapKit

class IconCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    class var identifier: String { return String(describing: self) }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = K.Colors.prettyGold
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = K.cornerRadius
        
        contentView.addSubview(imageView)
        

        imageView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(contentView)
        }
    }
    
    public func configure(with model: CollectionCellViewModel) {
        #warning("TODO: add OK-ish images for IconsCollection")
        imageView.image = UIImage.placeholder()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
