//
//  AppCoordonator.swift
//  CoordinatorPractice
//
//  Created by 노주영 on 5/15/24.
//

import UIKit

class ToDoListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    var viewModel = ToDoListViewModel()
    
    let vc = ToDoListView()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        vc.coordinator = self
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAddToDoListView() {
        let coordinator = AddToDoListCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    func showDetailToDoListView(row: Int) {
        let coordinator = DetailToDoListCoordinator(
            navigationController: navigationController,
            viewModel: viewModel,
            listItem: self.viewModel.toDoList[row],
            row: row)
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

extension ToDoListCoordinator: AddToDoDelegate {
    func reloadData() {
        self.vc.tableView.reloadData()
    }
    
    func dismiss(coordinator: AddToDoListCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

extension ToDoListCoordinator: DetailToDoDelegate {
    func dismiss(coordinator: DetailToDoListCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
