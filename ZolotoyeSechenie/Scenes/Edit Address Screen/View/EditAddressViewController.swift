//
//  EditAddressViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 24.01.2023.
//

import UIKit
import SnapKit
import Combine

#warning("TODO: finish scroll for keyboard. Get rid of LabelTextField")
class EditAddressViewController: UIViewController {
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var cityLabelTextField = LabelTextField(labelText: "Город")
    private lazy var districtLabelTextField = LabelTextField(labelText: "Район")
    private lazy var streetLabelTextField = LabelTextField(labelText: "Улица")
    private lazy var buildingLabelTextField = LabelTextField(labelText: "Дом")
    private lazy var apartmentLabelTextField = LabelTextField(labelText: "Квартира/офис")

    private lazy var aboutMeLabel = UILabel()
    private lazy var aboutMeTextView = UITextView()
    
    private lazy var saveBtn = UIButton()
    private lazy var loadingView = LoadingView(withBackground: true)
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: EditAddressViewModel
    
    // MARK: - Life Cycle
    
    init(viewModel: EditAddressViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes
        hideKeyboardWhenTappedAround()
        registerForKeyboardNotifications()
        setupBinding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupScrollView()
        setupUI()
        saveBtnSetup()
    }
    
    // MARK: - Binding to viewModel
    
    func setupBinding() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isLoading  in
                isLoading ? self?.loadingView.startLoading() : self?.loadingView.endLoading()
            }
            .store(in: &subscriptions)

        viewModel.$title
            .receive(on: DispatchQueue.main)
            .assign(to: \.title, on: self)
            .store(in: &subscriptions)
        
        viewModel.$addressInfo
            .receive(on: DispatchQueue.main)
            .sink {[weak self] address in
                self?.populateAddress(with: address)
            }
            .store(in: &subscriptions)

    }
    
    
    private func populateAddress(with address: Address?) {
        guard let address else { return }
        cityLabelTextField.setText(with: address.city)
        districtLabelTextField.setText(with: address.district)
        streetLabelTextField.setText(with: address.street)
        buildingLabelTextField.setText(with: address.building)
        apartmentLabelTextField.setText(with: address.apartment)
    }
    
    // MARK: - UI
    
    private func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.center.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    private func setupUI() {
        
        contentView.addSubview(cityLabelTextField)
        cityLabelTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        contentView.addSubview(districtLabelTextField)
        districtLabelTextField.snp.makeConstraints { make in
            make.top.equalTo(cityLabelTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        contentView.addSubview(streetLabelTextField)
        streetLabelTextField.snp.makeConstraints { make in
            make.top.equalTo(districtLabelTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        contentView.addSubview(buildingLabelTextField)
        buildingLabelTextField.snp.makeConstraints { make in
            make.top.equalTo(streetLabelTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        contentView.addSubview(apartmentLabelTextField)
        apartmentLabelTextField.snp.makeConstraints { make in
            make.top.equalTo(buildingLabelTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
        }
        
        aboutMeLabelSetup()
        aboutMeTextViewSetup()
        
        view.addSubview(loadingView)
        loadingView.frame = view.frame
    }
    
    
    
    private func aboutMeLabelSetup(){
        contentView.addSubview(aboutMeLabel)
        aboutMeLabel.text = "Примечания"
        aboutMeLabel.font = K.Fonts.regular15
        aboutMeLabel.textColor = .black
        
        aboutMeLabel.snp.makeConstraints{ make in
            make.top.equalTo(apartmentLabelTextField.snp.bottom).offset(12)
            make.trailing.equalToSuperview().inset(K.hPadding)
            make.leading.equalToSuperview().offset(K.hPadding + 20)
        }
        
    }
    
    private func aboutMeTextViewSetup(){
        contentView.addSubview(aboutMeTextView)
        
        aboutMeTextView.textColor = K.Colors.darkGold
        aboutMeTextView.font = K.Fonts.regular17
        aboutMeTextView.layer.cornerRadius = K.cornerRadius
        aboutMeTextView.backgroundColor = K.Colors.prettyGold.withAlphaComponent(0.1)
        aboutMeTextView.textContainerInset = UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18)
        #warning("TODO: add label-like placeholder")
        aboutMeTextView.snp.makeConstraints{make in
            make.top.equalTo(aboutMeLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.height.equalTo(180)
        }
    }
    
    private func saveBtnSetup() {
        saveBtn.addTarget(self, action: #selector(saveBtnPressed), for: .touchUpInside)
        
        saveBtn.setTitle("Сохранить", for: .normal)
        saveBtn.titleLabel?.font = K.Fonts.semibold17
        saveBtn.backgroundColor = K.Colors.prettyGold
        saveBtn.layer.masksToBounds = false
        saveBtn.layer.cornerRadius = K.cornerRadius
        
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(saveBtn)
        
        saveBtn.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(K.hPadding)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(aboutMeTextView.snp.bottom).offset(10)
        }
    }
    
    @objc
    private func saveBtnPressed() {
        #warning("TODO: normal validation")
        let address = Address(id: "", city: "", district: "", street: "", building: "", apartment: "", comment: "", userId: "")
        viewModel.saveAddress(address)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc
    private func onKeyboardAppear(_ notification: NSNotification) {
        let info = notification.userInfo!
        let rect: CGRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        let kbSize = rect.size

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets

        var aRect = self.view.frame;
        aRect.size.height -= kbSize.height;
#warning("TODO: finish this")
//        let activeField: UITextField? = [cityLabelTextField,
//                                         districtLabelTextField,
//                                         streetLabelTextField,
//                                         buildingLabelTextField,
//                                         apartmentLabelTextField,
//                                         aboutMeTextView]
//            .first { $0.isFirstResponder }
//        if let activeField = activeField {
//            if !aRect.contains(activeField.frame.origin) {
//                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y-kbSize.height)
//                scrollView.setContentOffset(scrollPoint, animated: true)
//            }
//        }
    }

    @objc func onKeyboardDisappear(_ notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}


