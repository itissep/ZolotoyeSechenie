//
//  Coordinator.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//

import UIKit
import Swinject

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    var container: Container? { get set }

    func start()
}

#warning("TODO: check it later for unAuthed user")
extension Coordinator {
    func childDidFinish(_ coordinator: Coordinator) {
        for (index, child) in children.enumerated() where child === coordinator {
                children.remove(at: index)
                break
        }
    }
}


