//
//  CourierDetailsViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 12.04.2023.
//

import UIKit
import Combine
import SnapKit

#warning("TODO: scrollView")
class CourierDetailsViewController: UIViewController {
    private lazy var contentView = UIView()
    private lazy var scrollView = UIScrollView()
    
    private lazy var districtTitleLabel = UILabel()
    private lazy var districtSelectionView = UIView()
    private lazy var districtCaptureLabel = UILabel()
    
    private lazy var addressTitleLabel = UILabel()
    private lazy var addressPickerView = PickerView()
    private lazy var newAddressButton = UIButton()
    
    private lazy var commentLabel = UILabel()
    private lazy var commentTextView = UITextView()
    
    private lazy var nextButton = UIButton()
    
    private let viewModel: CourierDetailsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: CourierDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupBinding()
        layout()
        hideKeyboardWhenTappedAround()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBinding() {
        viewModel.$addressSelectionViewModels
            .sink { [weak self] models in
                self?.addressPickerView.configure(with: models)
            }
            .store(in: &subscriptions)
    }
    
    private func layout() {
        view.backgroundColor = .white
        title = "Доставка курьером"
        
        districtPickerSetup()
        addressPickerSetup()
        commentSectionSetup()
    }
    
    private func setupScrollView() {
//        view.backgroundColor = .white
//
//        scrollView.isUserInteractionEnabled = true
//        scrollView.isExclusiveTouch = false
//        scrollView.canCancelContentTouches = true
//        scrollView.delaysContentTouches = false
//
        
//        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
//
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 800)


        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.isScrollEnabled = false

        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
//        contentView = self.view
    }
    
    private func districtPickerSetup() {
        contentView.addSubviews([districtTitleLabel, districtSelectionView,districtCaptureLabel])
        districtTitleLabel.text = "Район города"
        districtTitleLabel.font = K.Fonts.semibold17
        districtTitleLabel.textColor = K.Colors.darkGold
        districtTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
//            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        districtSelectionView.backgroundColor = K.Colors.prettyGold
        districtSelectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.top.equalTo(districtTitleLabel.snp.bottom).offset(12)
            make.height.equalTo(45)
        }
        
        districtCaptureLabel.text = viewModel.getDistrictCapture()
        districtCaptureLabel.font = K.Fonts.regular13
        districtCaptureLabel.textColor = K.Colors.darkGold.withAlphaComponent(0.5)
        districtCaptureLabel.numberOfLines = 0
        districtCaptureLabel.snp.makeConstraints { make in
            make.leading.equalTo(districtSelectionView.snp.leading).inset(K.hPadding)
            make.trailing.equalTo(districtSelectionView.snp.trailing).inset(K.hPadding)
            make.top.equalTo(districtSelectionView.snp.bottom).offset(12)
        }
    }
    
    private func addressPickerSetup() {
        contentView.addSubviews([addressTitleLabel, addressPickerView, newAddressButton])
        addressTitleLabel.text = "Адрес"
        addressTitleLabel.font = K.Fonts.semibold17
        addressTitleLabel.textColor = K.Colors.darkGold
        addressTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.top.equalTo(districtCaptureLabel.snp.bottom).offset(20)
        }
        
        addressPickerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(addressTitleLabel.snp.bottom).offset(12)
        }
        
        newAddressButton.addTarget(self, action: #selector(addAddressPressed), for: .touchUpInside)
        newAddressButton.setTitle("Добавить новый адрес", for: .normal)
        
        let buttonImage = UIImage(named: "Plus") ?? UIImage()
        newAddressButton.setImage(buttonImage, for: .normal)
        #warning("TODO: move plus image to right")
        
        newAddressButton.titleLabel?.font = K.Fonts.semibold17
        newAddressButton.backgroundColor = K.Colors.prettyGold.withAlphaComponent(0.1)
        newAddressButton.setTitleColor(K.Colors.darkGold, for: .normal)
        newAddressButton.layer.masksToBounds = false
        newAddressButton.layer.cornerRadius = K.cornerRadius
        newAddressButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.top.equalTo(addressPickerView.snp.bottom)
            make.height.equalTo(50)
        }
    }
    private func commentSectionSetup() {
        contentView.addSubviews([commentLabel, commentTextView])
        commentLabel.text = "Примечания"
        commentLabel.font = K.Fonts.regular15
        commentLabel.textColor = .black
        
        commentLabel.snp.makeConstraints{ make in
            make.top.equalTo(newAddressButton.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(K.hPadding)
            make.leading.equalToSuperview().offset(K.hPadding + 20)
        }
        
        commentTextView.textColor = K.Colors.darkGold
        commentTextView.font = K.Fonts.regular17
        commentTextView.layer.cornerRadius = K.cornerRadius
        commentTextView.backgroundColor = K.Colors.prettyGold.withAlphaComponent(0.1)
        commentTextView.textContainerInset = UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18)
        #warning("TODO: add label-like placeholder")
        commentTextView.snp.makeConstraints{make in
            make.top.equalTo(commentLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.height.equalTo(180)
        }
    }
    
    private func nextButtonSetup() {
        contentView.addSubviews([nextButton])
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        
        nextButton.setTitle("Далее", for: .normal)
        nextButton.titleLabel?.font = K.Fonts.semibold17
        nextButton.backgroundColor = K.Colors.prettyGold
        nextButton.layer.masksToBounds = false
        nextButton.layer.cornerRadius = K.cornerRadius
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(K.hPadding)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(commentTextView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    @objc
    func addAddressPressed() {
        print(contentView.frame)
        print(scrollView.frame)
        print(view.frame)
//        viewModel.goToAddAddress()
    }
    
    @objc
    func nextButtonPressed() {
        viewModel.goToNextScreen()
    }
}
