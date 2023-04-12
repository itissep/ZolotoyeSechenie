//
//  GenericTableView.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

// TODO: unable visible selection of the cells

import UIKit

final class GenericTableView: UITableView {
    init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame, style: .plain)

        self.separatorStyle = .none

        self.register(GenericTableCell.self, forCellReuseIdentifier: GenericTableCell.identifier)

        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
