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
    private lazy var contentView = UIView()
    private lazy var scrollView = UIScrollView()
    
    private lazy var cityTitleLabel = UILabel()
    private lazy var selectCityView = UIView()
    private lazy var deliveryPickerTitle = UILabel()
    private lazy var tableView = UITableView()
    
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
        setupScrollView()
        layout()
        setupTableView()
//        setupLoadingView()
    }
    
    // MARK: - Binding
    
    private func bindToViewModel() {
        viewModel.$ratioPickerCellModels
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - UI
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        let label = UILabel()
        label.text = "some text"
        contentView.addSubview(label)
    }
    
    private func layout() {
        contentView.addSubviews([cityTitleLabel, selectCityView, deliveryPickerTitle])
        
        cityTitleLabel.text = "Населенный пункт"
        cityTitleLabel.font = K.Fonts.semibold17
        cityTitleLabel.textColor = K.Colors.darkGold
        cityTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(K.hPadding)
            make.top.equalToSuperview().inset(12)
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
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(RadioTableCell.self, forCellReuseIdentifier: RadioTableCell.identifier)
        
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        
        tableView.backgroundColor = .orange
        
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(400)
            make.centerX.equalToSuperview()
            make.top.equalTo(deliveryPickerTitle.snp.bottom).offset(20)
        }
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.frame = view.frame
    }
}


// MARK: - UITableViewDelegate

extension DelieveryDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RadioTableCell else {
            print("problem is here")
            return
        }
//        cell.toggle()
        print("something")
    }
}

// MARK: - UITableViewDataSource

extension DelieveryDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.ratioPickerCellModels.count)
        return viewModel.ratioPickerCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: RadioTableCell.identifier, for: indexPath) as? RadioTableCell
        else {
            fatalError("Something wrong with RadioTableCell")
        }
        let model = viewModel.ratioPickerCellModels[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}

final class DelieveryDetailsViewModel: NSObject {
    
    @Published var ratioPickerCellModels: [RadioViewModel] = MockData.ratioSelections
//    private let coordinator =
    #warning("TODO: add order flow coordinator")
    
    override init() {
        super.init()
        getRatioModels()
    }
    
    private func getCitySelectionOptions() {
        
    }
    
    private func getRatioModels() {
        #warning("TODO: move somewhere okay-ish")
        ratioPickerCellModels = MockData.ratioSelections
    }
}
