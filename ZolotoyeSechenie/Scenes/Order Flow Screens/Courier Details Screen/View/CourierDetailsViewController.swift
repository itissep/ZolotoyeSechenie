//
//  CourierDetailsViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 12.04.2023.
//

import UIKit
import Combine
import SnapKit

#warning("TODO: scrollView for kayboard")
#warning("TODO: fix constraints")
class CourierDetailsViewController: UIViewController {
    private lazy var scrollView = UIScrollView()
    private lazy var scrollViewContainer = UIStackView()
    
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
    
    // MARK: - Life Cycle
    
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
    
    // MARK: - Binding
    
    private func setupBinding() {
        viewModel.$addressSelectionViewModels
            .sink { [weak self] models in
                self?.addressPickerView.configure(with: models)
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - UI
    
    private func layout() {
        view.backgroundColor = .white
        title = "Доставка курьером"
        
        districtPickerSetup()
        addressPickerSetup()
        commentSectionSetup()
        nextButtonSetup()
    }
    
    private func setupScrollView() {
        scrollViewContainer.axis = .vertical
        scrollViewContainer.spacing = 10
        scrollViewContainer.alignment = .fill

        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
        
        scrollViewContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func districtPickerSetup() {
        [districtTitleLabel, districtSelectionView,districtCaptureLabel].forEach { view in
            scrollViewContainer.addArrangedSubview(view)
        }
        
        districtTitleLabel.text = "Район города"
        districtTitleLabel.font = K.Fonts.semibold17
        districtTitleLabel.textColor = K.Colors.darkGold
        
        districtSelectionView.backgroundColor = K.Colors.prettyGold
        districtSelectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.height.equalTo(45)
        }
        
        districtCaptureLabel.text = viewModel.getDistrictCapture()
        districtCaptureLabel.font = K.Fonts.regular13
        districtCaptureLabel.textColor = K.Colors.darkGold.withAlphaComponent(0.5)
        districtCaptureLabel.numberOfLines = 0
    }
    
    private func addressPickerSetup() {
        [addressTitleLabel, addressPickerView, newAddressButton].forEach { view in
                scrollViewContainer.addArrangedSubview(view)
            }
        addressTitleLabel.text = "Адрес"
        addressTitleLabel.font = K.Fonts.semibold17
        addressTitleLabel.textColor = K.Colors.darkGold
        
        addressPickerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        newAddressButton.addTarget(self, action: #selector(addAddressPressed), for: .touchUpInside)
        newAddressButton.setTitle("Добавить новый адрес", for: .normal)
        
        let buttonImage = UIImage(named: "Plus") ?? UIImage()
        #warning("TODO: add plus image to right")
        
        newAddressButton.titleLabel?.font = K.Fonts.semibold17
        newAddressButton.backgroundColor = K.Colors.prettyGold.withAlphaComponent(0.1)
        newAddressButton.setTitleColor(K.Colors.darkGold, for: .normal)
        newAddressButton.layer.masksToBounds = false
        newAddressButton.layer.cornerRadius = K.cornerRadius
        newAddressButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.height.equalTo(50)
        }
    }
    private func commentSectionSetup() {
        [commentLabel, commentTextView].forEach { view in
            scrollViewContainer.addArrangedSubview(view)
        }
        
        commentLabel.text = "Примечания"
        commentLabel.font = K.Fonts.regular15
        commentLabel.textColor = .black
        
        commentTextView.textColor = K.Colors.darkGold
        commentTextView.font = K.Fonts.regular17
        commentTextView.layer.cornerRadius = K.cornerRadius
        commentTextView.backgroundColor = K.Colors.prettyGold.withAlphaComponent(0.1)
        commentTextView.textContainerInset = UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18)
        #warning("TODO: add label-like placeholder")
        commentTextView.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.height.equalTo(100)
        }
    }
    
    private func nextButtonSetup() {
        scrollViewContainer.addArrangedSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        
        nextButton.setTitle("Далее", for: .normal)
        nextButton.titleLabel?.font = K.Fonts.semibold17
        nextButton.backgroundColor = K.Colors.prettyGold
        nextButton.layer.masksToBounds = false
        nextButton.layer.cornerRadius = K.cornerRadius
        
        nextButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(K.hPadding)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    // MARK: - Selectors
    
    @objc
    func addAddressPressed() {
        viewModel.goToAddAddress()
    }
    
    @objc
    func nextButtonPressed() {
        viewModel.goToNextScreen()
    }
}
