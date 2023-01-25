//
//  CustomTextField.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 24.01.2023.
//

import UIKit
import SnapKit


final class CustomTextField: UIView {
    
    private let backgroundView = UIView()
    private let textField = UITextField()
    private let iconImageView = UIImageView()
    
    private var viewModel: CustomTextFieldViewModel
    
    init(frame: CGRect = CGRect.zero, viewModel: CustomTextFieldViewModel){
        
        self.viewModel = viewModel
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup(){
        backgroundViewSetup()
        iconImageViewSetup()
        textFieldSetup()
    }
    
    private func backgroundViewSetup(){
        addSubview(backgroundView)
        
        backgroundView.backgroundColor = K.Colors.prettyGold.withAlphaComponent(0.1)
        backgroundView.layer.cornerRadius = 16
        
        backgroundView.snp.makeConstraints{make in
            make.edges.equalToSuperview()
            
        }
    }
    
    private func iconImageViewSetup(){
        backgroundView.addSubview(iconImageView)
        
        switch viewModel.type {
        case .withoutImage:
            break
        case .withImageOnLeft:
            iconImageSetup()
            
            iconImageView.snp.makeConstraints{make in
                make.leading.equalToSuperview().offset(10)
                make.centerY.equalToSuperview()
                make.height.width.equalTo(24)
            }
            break
        case .withImageOnRight:
            iconImageSetup()
            
            iconImageView.snp.makeConstraints{make in
                make.trailing.equalToSuperview().inset(10)
                make.centerY.equalToSuperview()
                make.height.width.equalTo(24)
            }
            break
        }
        
    }
    
    private func iconImageSetup(){
        iconImageView.image = viewModel.image
        iconImageView.contentMode = .scaleAspectFit
//        guard iconImageView.image == K.Icons.closeEye else {
//            return
//        }
        changePasswordVisibility()
        iconImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePasswordVisibility)))
        iconImageView.isUserInteractionEnabled = true
    }
    
    private func textFieldSetup(){
        backgroundView.addSubview(textField)
        
        textField.keyboardType = viewModel.keyboardType
        textField.attributedPlaceholder = NSAttributedString(string: viewModel.placeholder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.font = K.Fonts.regular17
        textField.textColor = K.Colors.darkGold
        textField.clearsOnBeginEditing = false
        textField.clearsOnInsertion = false
        
        textField.delegate = self
        
        textField.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
        }
        
        switch viewModel.type{
        case .withoutImage:
            textField.snp.makeConstraints{make in
                make.leading.trailing.equalToSuperview().inset(18)
            }
            break
        case .withImageOnLeft:
            textField.snp.makeConstraints{make in
                make.leading.equalTo(iconImageView.snp.trailing).offset(10)
                make.trailing.equalToSuperview().offset(-18)
            }
            break
        case .withImageOnRight:
            textField.snp.makeConstraints{make in
                make.leading.equalToSuperview().offset(18)
                make.trailing.equalTo(iconImageView.snp.leading).offset(-10)
            }
            break
        }
    }
    
    var lastText: String?
    
    @objc private func changePasswordVisibility() {
        textField.isSecureTextEntry.toggle()

//        iconImageView.image = iconImageView.image == K.Icons.openEye ? K.Icons.closeEye : K.Icons.openEye
    }
    
    public func returnText() -> String{
        return textField.text ?? ""
    }
    
    
    
}

extension CustomTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard
            let text = textField.text,
            let textRange = Range(range, in: text)
        else {
            return false
        }
        
        let updatedString = textField.text?.replacingCharacters(in: textRange, with: string)
        textField.text = updatedString
        
        return false
    }
}
