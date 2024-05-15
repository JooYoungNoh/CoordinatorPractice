//
//  ThirdCoordinator.swift
//  CoordinatorPractice
//
//  Created by 노주영 on 5/15/24.
//

import UIKit

class DetailToDoListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    var viewModel: ToDoListViewModel
    var listItem: ToDo
    var row: Int
    
    weak var delegate: DetailToDoDelegate?
    
    init(
        navigationController: UINavigationController,
        viewModel: ToDoListViewModel,
        listItem: ToDo,
        row: Int
    ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.listItem = listItem
        self.row = row
    }
    
    func start() {
        let detailViewController = DetailToDoListView(
            coordinator: self,
            viewModel: viewModel,
            listItem: self.viewModel.toDoList[row],
            row: row)
        
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func dismiss() {
        self.navigationController.popViewController(animated: true)
        delegate?.dismiss(coordinator: self)
    }
}
