//
//  SecondCoordinator.swift
//  CoordinatorPractice
//
//  Created by 노주영 on 5/15/24.
//

import UIKit

class AddToDoListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    var viewModel: ToDoListViewModel
    
    weak var delegate: AddToDoDelegate?
    
    init(navigationController: UINavigationController, viewModel: ToDoListViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let addViewController = AddToDoListView(coordinator: self, viewModel: viewModel)
        
        addViewController.modalPresentationStyle = .overFullScreen
        addViewController.modalTransitionStyle = .crossDissolve
        
        self.navigationController.present(addViewController, animated: true)
    }
    
    func dismiss() {
        self.navigationController.dismiss(animated: true)
        delegate?.dismiss(coordinator: self)
    }
}
