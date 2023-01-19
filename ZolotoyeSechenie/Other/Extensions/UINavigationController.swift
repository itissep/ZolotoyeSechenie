//
//  UINavigationController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//

import UIKit

extension UINavigationController{
    
    static func createDefault() -> UINavigationController{
        let navCont = UINavigationController()
        
        navCont.setNavigationBarHidden(true, animated: false)
        
        return navCont
    }
    
    static func createForAuth() -> UINavigationController{
        let navCont = UINavigationController()
        navCont.setNavigationBarHidden(false, animated: false)
        
//        let backButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
//        backButton.setBackgroundImage(Constants.Icons.backArrow, for: .normal, barMetrics: .default)
//        
//        navCont.navigationItem.setLeftBarButton(backButton, animated: false)
        
        return navCont
    }
}
