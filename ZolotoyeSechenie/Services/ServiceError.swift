//
//  ServiceError.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 11.04.2023.
//

import Foundation

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
    // notificationService
    case fetchAllNotificationsFailture, fetchNotificationInfoFailture
    
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
        // notificationServiec
        case .fetchAllNotificationsFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Fetch All Notifications Failture"
            )
        case .fetchNotificationInfoFailture:
            return NSLocalizedString(
                "Произошла ошибка с отправкой изображения. Попробуйте еще.",
                comment: "Fetch Notification Info Failture"
            )
        }
    }
}
