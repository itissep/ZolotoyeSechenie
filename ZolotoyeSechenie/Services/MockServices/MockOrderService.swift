//
//  MockOrderService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 06.04.2023.
//

import Foundation

final class MockOrderService: OrderServiceDescription {
    func createOrder(for userId: String, with order: Order, _ completion: @escaping (Result<Order, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + K.loadingTime) {
            completion(.success(MockData.order))
//            completion(.failure(ServiceError.createOrderFailture))
        }
    }
    
    func deleteOrder(with orderId: String, _ completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + K.loadingTime) {
            completion(.success(()))
//            completion(.failure(ServiceError.deleteOrderFailture))
        }
    }
    
    func getAllOrders(for userId: String, _ completion: @escaping (Result<[Order], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + K.loadingTime) {
            completion(.success(MockData.orders))
//            completion(.failure(ServiceError.fetchAllOrdersFailture))
        }
    }
    
    func getOrderInfo(with orderId: String, _ completion: @escaping (Result<Order, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + K.loadingTime) {
            completion(.success(MockData.order))
//            completion(.failure(ServiceError.fetchOrderInfoFailture))
        }
    }
    
    func getDelieveriesCount(for userId: String, _ completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + K.loadingTime) {
            completion(.success(5))
//            completion(.failure(ServiceError.deliveryCountFailture))
        }
    }
    
    func updateOrderStatus(for orderId: String, _ completion: @escaping (Result<Order, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + K.loadingTime) {
            completion(.success(MockData.order))
//            completion(.failure(ServiceError.updateOrderStatusFailture))r
        }
    }
    
    
}
