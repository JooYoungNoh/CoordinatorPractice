//
//  Coordinator.swift
//  CoordinatorPractice
//
//  Created by 노주영 on 5/15/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
