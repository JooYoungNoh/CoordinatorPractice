//
//  AppCoordinator.swift
//  CoordinatorPractice
//
//  Created by 노주영 on 5/15/24.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let coordinator = ToDoListCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
