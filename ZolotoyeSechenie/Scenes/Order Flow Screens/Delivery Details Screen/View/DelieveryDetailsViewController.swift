//
//  DelieveryDetailsViewController.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 12.04.2023.
//

import UIKit
import SnapKit
import Combine

final class DelieveryDetailsViewController: UIViewController {
    
    private lazy var cityTitleLabel = UILabel()
    private lazy var selectCityView = UIView()
    private lazy var deliveryPickerTitle = UILabel()
    private lazy var tableView = UITableView()
    private lazy var deliveriesView = PickerView()
    private lazy var nextBtn = UIButton()
    
    private lazy var loadingView = LoadingView(withBackground: true)
    
    private let viewModel: DelieveryDetailsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life Cycle
    
    init(viewModel: DelieveryDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Данные доставки"
        navigationController?.navigationBar.titleTextAttributes = K.Unspecified.titleAttributes
        view.backgroundColor = .white
        

        bindToViewModel()

        layout()
        setupDeliveryMethodSelection()
        nextBtnSetup()
    }
    
    // MARK: - Binding
    
    private func bindToViewModel() {
//        viewModel.$ratioPickerCellModels
//            .sink { [weak self] _ in
//                self?.tableView.reloadData()
//            }
//            .store(in: &subscriptions)
    }
    
    // MARK: - UI
    
    private func layout() {
        view.addSubviews([cityTitleLabel, selectCityView, deliveryPickerTitle])
        
        cityTitleLabel.text = "Населенный пункт"
        cityTitleLabel.font = K.Fonts.semibold17
        cityTitleLabel.textColor = K.Colors.darkGold
        cityTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        #warning("TODO: add normal select")
        selectCityView.backgroundColor = K.Colors.prettyGold
        selectCityView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.top.equalTo(cityTitleLabel.snp.bottom).offset(12)
            make.height.equalTo(42)
        }
        
        deliveryPickerTitle.text = "Способ доставки"
        deliveryPickerTitle.font = K.Fonts.semibold17
        deliveryPickerTitle.textColor = K.Colors.darkGold
        deliveryPickerTitle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.top.equalTo(selectCityView.snp.bottom).offset(20)
        }
    }
    
    private func setupDeliveryMethodSelection() {
        view.addSubviews([deliveriesView])
        deliveriesView.configure(with: MockData.ratioSelections)
        deliveriesView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(deliveryPickerTitle.snp.bottom).offset(20)
        }
    }
    
    private func nextBtnSetup() {
        nextBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        
        nextBtn.setTitle("Далее", for: .normal)
        nextBtn.titleLabel?.font = K.Fonts.semibold17
        nextBtn.backgroundColor = K.Colors.prettyGold
        nextBtn.layer.masksToBounds = false
        nextBtn.layer.cornerRadius = K.cornerRadius
        
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextBtn)
        
        nextBtn.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(K.hPadding)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(deliveriesView.snp.bottom).offset(10)
        }
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.frame = view.frame
    }
    
    @objc
    private func nextBtnPressed() {
        let deliveryMethodIndex = deliveriesView.selectedIndex
        viewModel.nextScreen(withCity: "", withMethodIndex: deliveryMethodIndex)
    }
}
