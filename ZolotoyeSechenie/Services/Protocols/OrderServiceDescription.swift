//
//  OrderServiceDescription.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 11.04.2023.
//

import Foundation

protocol OrderServiceDescription { // add types like history, currents and so on
    func createOrder(for userId: String, with order: Order, _ completion: @escaping (Result<Order, Error>) -> Void)
    func deleteOrder(with orderId: String, _ completion: @escaping (Result<Void, Error>) -> Void)
    func getAllOrders(for userId: String, _ completion: @escaping (Result<[Order], Error>) -> Void)
    func getOrderInfo(with orderId: String, _ completion: @escaping (Result<Order, Error>) -> Void)
    func getDelieveriesCount(for userId: String, _ completion: @escaping (Result<Int, Error>) -> Void)
    func updateOrderStatus(for orderId: String, _ completion: @escaping (Result<Order, Error>) -> Void)
}
