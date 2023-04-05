//
//  GenericCollectionView.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import UIKit

final class GenericCollectionView: UICollectionView {
    
    init(frame: CGRect = CGRect.zero){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 213, height: 125)
        layout.sectionInset = UIEdgeInsets(top: 0, left: K.hPadding, bottom: 0, right: K.hPadding)
        
        layout.minimumInteritemSpacing = 17
        layout.minimumLineSpacing = 17
        
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.register(GenericCollectionCell.self, forCellWithReuseIdentifier: GenericCollectionCell.identifier)
        
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .white
    }
    
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}
