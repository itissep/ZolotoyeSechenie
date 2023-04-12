//
//  DeliveryDetailsViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 12.04.2023.
//

import Foundation

final class DelieveryDetailsViewModel: NSObject {
    
    @Published var ratioPickerCellModels: [PickerViewModel] = MockData.ratioSelections
    private let coordinator: OrderCoordinatorDescription
    
    init(coordinator: OrderCoordinatorDescription) {
        self.coordinator = coordinator
        super.init()
        getRatioModels()
    }
    
    private func getCitySelectionOptions() {
        #warning("TODO: city selector")
    }
    
    private func getRatioModels() {
        #warning("TODO: move somewhere okay-ish")
        ratioPickerCellModels = MockData.ratioSelections
    }
    
    public func nextScreen(withCity city: String, withMethodIndex index: Int) {
        if index == 1 {
            coordinator.goToCourierDetailsScreen(with: city)
        } else {
            print("to payment screen")
        }
    }
}
