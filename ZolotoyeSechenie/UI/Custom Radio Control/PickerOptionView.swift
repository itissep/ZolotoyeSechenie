//
//  RadioView.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 12.04.2023.
//

import Foundation
import UIKit
import SnapKit

final class PickerOptionView: UIView {
    private lazy var innerView = UIView()
    private lazy var captureLabel = UILabel()
    private lazy var iconImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var radioImageView = UIImageView()
    
    private var id: String?
    var isChecked = false {
        didSet {
            ratioSetup(isChecked)
        }
    }
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout() {
        self.addSubviews([innerView, captureLabel])
        
        innerView.addSubviews([iconImageView, titleLabel, radioImageView])
    
        innerView.layer.cornerRadius = K.cornerRadius
        innerView.layer.masksToBounds = true
        innerView.backgroundColor = K.Colors.prettyGold.withAlphaComponent(0.1)
        innerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.top.equalToSuperview()
            make.height.equalTo(64)
        }
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(K.hPadding)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(40)
        }
        
        titleLabel.font = K.Fonts.regular15
        titleLabel.textColor = K.Colors.darkGold
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
        
        radioImageView.contentMode = .scaleAspectFit
        radioImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        captureLabel.numberOfLines = 0
        captureLabel.textColor = K.Colors.darkGold.withAlphaComponent(0.5)
        captureLabel.font = K.Fonts.regular13
        captureLabel.snp.makeConstraints { make in
            make.leading.equalTo(innerView.snp.leading).inset(K.hPadding)
            make.trailing.equalTo(innerView.snp.trailing).inset(K.hPadding)
            make.top.equalTo(innerView.snp.bottom).offset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    private func ratioSetup(_ isChecked: Bool) {
        if isChecked {
            radioImageView.image = UIImage.systemWithConfig(name: "circle.inset.filled", size: 30)
        } else {
            radioImageView.image = UIImage.systemWithConfig(name: "circle", size: 30)
        }
    }
    
    public func configure(with model: PickerViewModel) {
        id = model.id
        titleLabel.text = model.title
        captureLabel.text = model.capture
        iconImageView.image = model.image
        isChecked = model.isChecked
    }
    
    @objc
    func toggle() {
        isChecked.toggle()
    }
}


final class PickerViewModel {
    let id: String
    let title: String
    let capture: String?
    let image: UIImage?
    let isChecked: Bool
    
    init(id: String, title: String, capture: String?, image: UIImage?, isChecked: Bool) {
        self.id = id
        self.title = title
        self.capture = capture
        self.image = image
        self.isChecked = isChecked
    }
    
    init(from address: Address) {
        self.id = address.id
        self.title = "ул.\(address.street), д. \(address.building), \(address.apartment)"
        self.image = UIImage(named: "house.fill")
        self.capture = nil
        self.isChecked = false
    }
}

final class PickerView: UIView {
    private lazy var stackView = UIStackView()
    private lazy var byCourrier = PickerOptionView()
    private lazy var fromStock = PickerOptionView()
    
    private var views: [PickerOptionView] = [] {
        didSet {
            views.forEach { stackView.addArrangedSubview($0) }
            views.first?.isChecked = true
            selectedIndex = 0
        }
    }
    var selectedIndex = 0
    
    init() {
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.alignment = .fill
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    public func configure(with models: [PickerViewModel]){
        var views: [PickerOptionView] = []
        for (index, model) in models.enumerated() {
            let view = PickerOptionView()
            view.configure(with: model)
            let gestureRecognizer = CustomTapGestureRecognizer(target: self,
                                                               action: #selector(optionTapped(_ :)),
                                                               index: index)
            view.addGestureRecognizer(gestureRecognizer)
            views.append(view)
        }
        self.views = views
    }
    
    @objc
    private func optionTapped(_ sender: CustomTapGestureRecognizer) {
        let index = sender.index
        views[selectedIndex].toggle()
        views[index].toggle()
        selectedIndex = index
    }
}

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    let index: Int
    
    init(target: AnyObject, action: Selector, index: Int) {
        self.index = index
        super.init(target: target, action: action)
    }
}
