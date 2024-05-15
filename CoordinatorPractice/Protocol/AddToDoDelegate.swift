//
//  UpdateTableView.swift
//  CoordinatorPractice
//
//  Created by 노주영 on 5/15/24.
//

protocol AddToDoDelegate: AnyObject {
    func reloadData()
    func dismiss(coordinator: AddToDoListCoordinator)
}
