//
//  CustomTextFielsViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 24.01.2023.
//

import UIKit

struct CustomTextFieldViewModel{
    
    let type: CustomTextFieldType
    let keyboardType: UIKeyboardType
    let placeholder: String
    let image: UIImage?
    
    init(type: CustomTextFieldType = .withoutImage, keyboardType: UIKeyboardType = .default, placeholder: String = "", image: UIImage? = nil){
        self.type = type
        self.keyboardType = keyboardType
        self.placeholder = placeholder
        self.image = image
    }
}
