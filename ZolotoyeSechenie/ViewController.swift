//
//  ViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 08.11.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let label = UILabel()
        label.text = "some shit"
        label.textColor = .brown
        
        view.addSubview(label)

        label.snp.makeConstraints { (make) -> Void in
                   make.width.height.equalTo(100)
                   make.center.equalTo(self.view)
                }
    }


}

