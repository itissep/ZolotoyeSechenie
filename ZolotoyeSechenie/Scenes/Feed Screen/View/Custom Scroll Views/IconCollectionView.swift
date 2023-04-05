//
//  IconCollectionView.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import UIKit

final class IconsCollectionView: UICollectionView {
    init(frame: CGRect = CGRect.zero){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 63, height: 63)
        layout.sectionInset = UIEdgeInsets(top: 0, left: K.hPadding, bottom: 0, right: K.hPadding)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.register(IconCollectionViewCell.self, forCellWithReuseIdentifier: IconCollectionViewCell.identifier)
        
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .white
    }
    
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}
