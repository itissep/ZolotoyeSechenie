//
//  OrdersViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation

class OrdersViewModel: NSObject {
    
    private var ordersService: OrdersServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var orders = Orders()
    
    var orderCellViewModels = [OrderCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(ordersService: OrdersServiceProtocol = OrdersService()) {
        self.ordersService = ordersService
    }
    
    func getOrders() {
        ordersService.getOrders { success, model, error in
            if success, let orders = model {
                self.fetchData(orders: orders)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(orders: Orders) {
        self.orders = orders // Cache
        var vms = [OrderCellViewModel]()
        for order in orders {
            vms.append(createCellModel(order: order))
        }
        orderCellViewModels = vms
    }
    
    func createCellModel(order: Order) -> OrderCellViewModel {
        let id = order.id
        // TODO: change data later
        return OrderCellViewModel(id: id) // change properties
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> OrderCellViewModel {
        return orderCellViewModels[indexPath.row]
    }
}
