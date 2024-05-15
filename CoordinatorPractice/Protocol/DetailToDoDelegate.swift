//
//  DetailToDoDelegate.swift
//  CoordinatorPractice
//
//  Created by 노주영 on 5/15/24.
//

protocol DetailToDoDelegate: AnyObject {
    func dismiss(coordinator: DetailToDoListCoordinator)
}
