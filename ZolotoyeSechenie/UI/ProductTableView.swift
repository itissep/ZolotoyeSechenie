//
//  ProductTableView.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

// TODO: unable visible selection of the cells

import UIKit

final class ProductTableView: UITableView {
    
    init(frame: CGRect = CGRect.zero){
        super.init(frame: frame, style: .plain)

        self.separatorStyle = .none
        
        self.register(ProductTableCell.self, forCellReuseIdentifier: ProductTableCell.identifier)
        
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .white
    }
    
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}
