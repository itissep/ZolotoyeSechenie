//
//  OrderPaymentMethodViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 12.04.2023.
//

import Foundation
import Combine

final class OrderPaymentMethodViewModel: NSObject {
    let coordinator: OrderCoordinatorDescription
    @Published var paymentOptionViews: [PickerViewModel] = []
    
    init(coordinator: OrderCoordinatorDescription) {
        self.coordinator = coordinator
        super.init()
        
        getPaymentMethods()
    }
    
    private func getPaymentMethods() {
        paymentOptionViews = MockData.paymentMethods
    }
    
    public func toOrderConformationScreen() {
        // coordinator.goToOrderConformation
    }
}
