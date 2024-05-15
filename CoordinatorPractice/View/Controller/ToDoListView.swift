//
//  ToDoListView.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/09.
//

import UIKit
import SnapKit

class ToDoListView: UIViewController {
    weak var coordinator: ToDoListCoordinator?
    
    var viewModel: ToDoListViewModel?
    
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(ToDoListCell.self, forCellReuseIdentifier: ToDoListCell.identifier)
        
        self.setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func setView() {
        //메인 뷰
        self.view.backgroundColor = .systemBackground
        
        //네비게이션 뷰
        self.navigationItem.title = "ToDoList"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonClick(_:)))
        
        //테이블 뷰
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: 액션 메소드
extension ToDoListView {
    @objc func addButtonClick(_ sender: UIBarButtonItem) {
        coordinator?.showAddToDoListView()
    }
}

//MARK: 테이블 뷰 메소드
extension ToDoListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListCell.identifier, for: indexPath) as? ToDoListCell else { return UITableViewCell() }
        
        cell.title.text = self.viewModel?.toDoList[indexPath.row].title
        cell.descriptionData.text = self.viewModel?.toDoList[indexPath.row].description
        cell.completedImage.image = UIImage(systemName: "checkmark.circle.fill")
        
        if self.viewModel?.toDoList[indexPath.row].completed ?? false {
            cell.completedImage.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.toDoList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ToDoListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showDetailToDoListView(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel?.toDoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
