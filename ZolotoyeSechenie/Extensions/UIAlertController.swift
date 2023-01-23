//
//  UIAlertController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import UIKit


extension UIAlertController{
    
    static func createAlert(withTitle title: String,
                            message: String,
                            buttonString: String,
                            actionHandler: @escaping (_: UIAlertAction?) -> Void) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        alert.addAction(cancelAction)
        
        let destructiveAction = UIAlertAction(title: buttonString,
                                              style: UIAlertAction.Style.destructive,
                                              handler: actionHandler)
        alert.addAction(destructiveAction)
        return alert
    }
}
