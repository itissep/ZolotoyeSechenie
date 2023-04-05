//
//  AuthServiceDescription.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import Foundation

protocol AuthServiceDescription {
    func isAuthed() -> Bool
    func signIn(with phoneNumber: String,
                _ completion: @escaping (Result<User, Error>) -> Void)
    func signOut(for userId: String,
                 _ completion: @escaping (Result<Void, Error>) -> Void)
}

protocol UserServiceDescription {
    func getUserInfo(for userId: String,
                     _ completion: @escaping (Result<User, Error>) -> Void)
    func editUserInfo(for userId: String,
                      with newModel: User,
                      _ completion: @escaping (Result<User, Error>) -> Void)
    func deleteUserInfo(for userId: String,
                        _ completion: @escaping (Result<Void, Error>) -> Void)
}

protocol UserDefaultsService {
    func getUserId() -> String
    func setUserId(with userId: String)
}


protocol ProductServiceDescription {
    func getProduct(with productId: String, _ completion: @escaping (Result<Product, Error>) -> Void)
    func getAllProducts(for collectionId: String?, _ completion: @escaping (Result<[Product], Error>) -> Void)
    func getCollections(for type: CollectionType, _ completion: @escaping (Result<[ProductCollection], Error>) -> Void)
    // find product by name
    // categories
}


protocol OrderServiceDescription { // add types like history, currents and so on
    func createOrder(for userId: String, with order: Order, _ completion: @escaping (Result<Order, Error>) -> Void)
    func deleteOrder(with orderId: String, _ completion: @escaping (Result<Void, Error>) -> Void)
    func getAllOrders(for userId: String, _ completion: @escaping (Result<[Order], Error>) -> Void)
    func getOrderInfo(with orderId: String, _ completion: @escaping (Result<Order, Error>) -> Void)
    func getDelieveriesCount(for userId: String, _ completion: @escaping (Result<Int, Error>) -> Void)
    func updateOrderStatus(for orderId: String, _ completion: @escaping (Result<Order, Error>) -> Void)
}

protocol AddressesServiceDescription {
    func getAllAddresses(for userId: String, _ completion: @escaping (Result<[Address], Error>) -> Void)
    func getAddress(with id: String,_ completion: @escaping (Result<Address, Error>) -> Void)
    func updateAddress(for addressId: String, with address: Address,_ completion: @escaping (Result<Address, Error>) -> Void)
    func addAddress(for userId: String, with address: Address, _ completion: @escaping (Result<Address, Error>) -> Void)
    func deleteAddress(with addressId: String, _ completion: @escaping (Result<Void, Error>) -> Void)
}

protocol NotificationServiceDescription {
    func getAllNotifications(for userId: String, _ completion: @escaping (Result<[UserNotification], Error>) -> Void)
    func getNotification(for notificationId: String, _ completion: @escaping (Result<UserNotification, Error>) -> Void)
}


enum ServiceError: Error {
    // authService errors
    case sighInFailture, signOutFailture
    // userService errors
    case userInfoError, editingUserInfoFailture, deletingUserFailture
    // productService errors
    case productInfoFailture, productsFetchFailture
    // imageService errors
    case imageFetchFailture, imageUploadFailture
    // addressService
    case addAddressFailture, fetchAddressesFailture, fetchAddressInfoFailture, updateAddressFailture, deleteAddressFailture
    // orderService
    case createOrderFailture, deleteOrderFailture, fetchAllOrdersFailture, fetchOrderInfoFailture, deliveryCountFailture, updateOrderStatusFailture
    
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        // authService errors
        case .sighInFailture:
            return NSLocalizedString(
                "Произошла ошибка со входом в профиль. Попробуйте снова или позвоните по нашему номеру +9 999 999 99 99",
                comment: "Sing In Failture"
            )
        case .signOutFailture:
            return NSLocalizedString(
                "Произошла ошибка с выходом из профиля.",
                comment: "Sing Out Failture"
            )
        // userService errors
        case .userInfoError:
            return NSLocalizedString(
                "Произошла ошибка получения данных профиля. Попробуйте перезагрузить приложение.",
                comment: "Fetch User Info Error"
            )
        case .editingUserInfoFailture:
            return NSLocalizedString(
                "Произошла ошибка редактирования данных. Попробуйте еще раз.",
                comment: "Edit User Info Failture"
            )
        case .deletingUserFailture:
            return NSLocalizedString(
                "Произошла ошибка удаления профиля. Вы никуда от нас не денетесь.",
                comment: "Delete User Failture"
            )
        // productService errors
        case .productInfoFailture:
            return NSLocalizedString(
                "Произошла ошибка c загрузкой данных продукта. Попробуйте еще раз.",
                comment: "Product Info Fetch Failture"
            )
        case .productsFetchFailture:
            return NSLocalizedString(
                "Произошла ошибка с загрузкой продуктов. Попробуйте еще раз.",
                comment: "Products Collection Fetch Failture"
            )
        case .imageFetchFailture:
            return NSLocalizedString(
                "Произошла ошибка с загрузкой изображения. Попробуйте еще раз.",
                comment: "Image Fetch Failture"
            )
        case .imageUploadFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Image Upload Failture"
            )
        // addressService
        case .addAddressFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Add Address Failture"
            )
        case .fetchAddressesFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Fetch Addresses Failture"
            )
        case .fetchAddressInfoFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Fetch Address Info Failture"
            )
        case .updateAddressFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Update Address Failture"
            )
        case .deleteAddressFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Delete Address Failture"
            )
        // orderService
        case .createOrderFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Create Order Failture"
            )
        case .deleteOrderFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Delete Order Failture"
            )
        case .fetchAllOrdersFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Fetch All Orders Failture"
            )
        case .fetchOrderInfoFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Fetch Order Info Failture"
            )
        case .deliveryCountFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Delivery Count Fetch Failture"
            )
        case .updateOrderStatusFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Update Order Status Failture"
            )
        }
    }
}
