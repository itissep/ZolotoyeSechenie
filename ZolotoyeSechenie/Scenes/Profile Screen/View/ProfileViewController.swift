//
//  ProfileViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//


import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let label = UILabel()
        label.text = "ProfileViewController"
        label.textColor = .brown
        
        view.addSubview(label)

        label.snp.makeConstraints { (make) -> Void in
                   make.width.height.equalTo(100)
                   make.center.equalTo(self.view)
                }
    }


}