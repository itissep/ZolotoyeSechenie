//
//  OrderPaymentMethodViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 12.04.2023.
//

import UIKit
import Combine
import SnapKit

final class OrderPaymentMethodViewController: UIViewController {
    private lazy var pickerTitleLabel = UILabel()
    private lazy var paymentPicker = PickerView()
    private lazy var nextButton = UIButton()
    
    private let viewModel: OrderPaymentMethodViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: OrderPaymentMethodViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Способ оплаты"
        setupBinding()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBinding() {
        viewModel.$paymentOptionViews
            .sink { [weak self] models in
                self?.paymentPicker.configure(with: models)
            }
            .store(in: &subscriptions)
    }
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubviews([pickerTitleLabel, paymentPicker, nextButton])
        pickerTitleLabel.text = "Выберите способ оплаты"
        pickerTitleLabel.font = K.Fonts.semibold17
        pickerTitleLabel.textColor = K.Colors.darkGold
        pickerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        paymentPicker.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(pickerTitleLabel.snp.bottom).offset(20)
        }
        
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        
        nextButton.setTitle("Далее", for: .normal)
        nextButton.titleLabel?.font = K.Fonts.semibold17
        nextButton.backgroundColor = K.Colors.prettyGold
        nextButton.layer.masksToBounds = false
        nextButton.layer.cornerRadius = K.cornerRadius
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(paymentPicker.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(K.hPadding)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc
    private func nextButtonPressed() {
        viewModel.toOrderConformationScreen()
    }
}
