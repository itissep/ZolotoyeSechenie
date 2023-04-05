//
//  SearchViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//

import UIKit


class SearchViewController: UIViewController {
    
//    weak var coordinator: SearchBaseCoordinator?
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
//        self.coordinator = coordinator
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let label = UILabel()
        label.text = "Search View Controller"
        label.textColor = .brown
        
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(100)
            make.center.equalTo(self.view)
        }
    }
    
    
}
