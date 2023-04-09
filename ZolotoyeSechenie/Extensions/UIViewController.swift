//
//  UIViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 09.04.2023.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showError(with error: Error) {
        DispatchQueue.main.async { [weak self] in
//            let alert = UIAlertController.createAlert(withTitle: "Error", message: error.localizedDescription )
//            self?.present(alert, animated: true)
            #warning("TODO: add normal errror presenter")
        }
    }
}
