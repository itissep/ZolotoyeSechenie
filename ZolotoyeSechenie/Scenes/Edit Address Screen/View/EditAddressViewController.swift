//
//  EditAddressViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 24.01.2023.
//

import UIKit
import SnapKit

// TODO: add user category and information about it

class EditAddressViewController: UIViewController {
    var type: EditAddressType
    
    private let cityLabelTextField = LabelTextField(
        viewModel: .init(),
        labelText: "Город")
    private let districtLabelTextField = LabelTextField(
        viewModel: .init(),
        labelText: "Район")
    private let streetLabelTextField = LabelTextField(
        viewModel: .init(),
        labelText: "Улица")
    private let buildingLabelTextField = LabelTextField(
        viewModel: .init(),
        labelText: "Дом")
    private let apartmentLabelTextField = LabelTextField(
        viewModel: .init(),
        labelText: "Квартира/офис")
    
    
    private let aboutMeLabel = UILabel()
    private let aboutMeTextView = UITextView()
    
    
    lazy var viewModel = {
        EditAddressViewModel(type: type)
    }()
    
    weak var coordinator: ProfileBaseCoordinator?
    
    
    init(coordinator: ProfileBaseCoordinator, type: EditAddressType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
//        self.type = type
        
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

        title = viewModel.getTitle()
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes
        
        
        initViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    func initViewModel() {
        
        viewModel.reloadData = { [weak self] in
            let address = self?.viewModel.address
            
            print(address)
            DispatchQueue.main.async {
                
//                self?.buildingLabelTextField.text = address?.building
                

            }
        }
        viewModel.getData()

    }
    
    private func setupUI() {
        
        view.addSubview(cityLabelTextField)
        cityLabelTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        view.addSubview(districtLabelTextField)
        districtLabelTextField.snp.makeConstraints { make in
            make.top.equalTo(cityLabelTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        view.addSubview(streetLabelTextField)
        streetLabelTextField.snp.makeConstraints { make in
            make.top.equalTo(districtLabelTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        view.addSubview(buildingLabelTextField)
        buildingLabelTextField.snp.makeConstraints { make in
            make.top.equalTo(streetLabelTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        view.addSubview(apartmentLabelTextField)
        apartmentLabelTextField.snp.makeConstraints { make in
            make.top.equalTo(buildingLabelTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        
        
        
        
//        nickNameLabelTextFieldSetup()
//       aboutMeLabelSetup()
//        aboutMeTextViewSetup()
    }
    
    
    
    private func aboutMeLabelSetup(){
        view.addSubview(aboutMeLabel)
        aboutMeLabel.text = "Примечания"
        aboutMeLabel.font = K.Fonts.regular15
        aboutMeLabel.textColor = .black
        
        aboutMeLabel.snp.makeConstraints{ make in
//            make.top.equalTo(nickNameLabelTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(48)
        }
        
    }
    
    private func aboutMeTextViewSetup(){
        view.addSubview(aboutMeTextView)
        
        aboutMeTextView.textColor = K.Colors.darkGold
        aboutMeTextView.font = K.Fonts.regular17
        aboutMeTextView.layer.cornerRadius = 16
        aboutMeTextView.backgroundColor = K.Colors.darkGold.withAlphaComponent(0.1)
//        aboutMeTextView.attributedPlaceholder = NSAttributedString(string: "Как найти вход или другое.",
//                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            // TODO: placeholder???
        
        aboutMeTextView.snp.makeConstraints{make in
            make.top.equalTo(aboutMeLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(180)
        }
    }
    
 
    
}


