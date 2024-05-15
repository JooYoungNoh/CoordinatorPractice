//
//  DetailToDoListView.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/27.
//

import UIKit
import SnapKit

class DetailToDoListView: UIViewController {
    weak var coordinator: DetailToDoListCoordinator?
    var viewModel: ToDoListViewModel?
    
    var listItem: ToDo
    var row: Int
    
    var isSelectDescriptionTextView: Bool = false
    var keyboardHeightConstTopDes: Constraint?
    var keyboardHeightConstBottomDes: Constraint?
    
    init(coordinator: DetailToDoListCoordinator?, viewModel: ToDoListViewModel, listItem: ToDo, row: Int) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.listItem = listItem
        self.row = row
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        return textView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var completedSeg: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["X", "O"])
        segControl.tintColor = .systemGray4
        return segControl
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionTextView.delegate = self
        self.setView()
        
        self.navigationItem.leftBarButtonItem = .init(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(closeButtonClick(_:)))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: 탭 제스처
extension DetailToDoListView {
    @objc func touchView(_ sender: Any){
        self.view.endEditing(true)
    }
    
    func uiTapCreate() {
        //탭 제스처
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchView(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
}

//MARK: 버튼 메소드
extension DetailToDoListView {
    @objc func closeButtonClick(_ sender: UIBarButtonItem) {
        coordinator?.dismiss()
    }
    
    @objc func saveButtomClick(_ sender: UIButton) {
        self.viewModel?.changeToDo(
            row: row,
            title: self.titleTextView.text,
            description: self.descriptionTextView.text,
            completed: self.completedSeg.selectedSegmentIndex == 1 ? true : false)
        
        coordinator?.dismiss()
    }
}

//MARK: textView 클릭 시 뷰가 올라가도록
extension DetailToDoListView {
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
            
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.isSelectDescriptionTextView {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                self.titleLabel.isHidden = true
                self.titleTextView.isHidden = true
                self.keyboardHeightConstTopDes?.update(offset: 10-(keyboardFrame.cgRectValue.height/3))
                self.keyboardHeightConstBottomDes?.update(offset: -(keyboardFrame.cgRectValue.height/3+30))
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.isSelectDescriptionTextView {
            self.titleLabel.isHidden = false
            self.titleTextView.isHidden = false
            self.keyboardHeightConstTopDes?.update(offset: 10)
            self.keyboardHeightConstBottomDes?.update(inset: -30)
        }
    }
}

//MARK: 화면 구현 부분
extension DetailToDoListView {
    func setView() {
        self.setKeyboardNotification()
        self.uiTapCreate()
        
        //메인 뷰
        self.view.backgroundColor = .systemBackground
        
        //네비게이션 뷰
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        //타이틀 부분
        self.titleTextView.text = self.listItem.title
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.titleTextView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.titleLabel)
            make.height.equalTo(40)
        }
        
        //저장 부분
        self.saveButton.addTarget(self, action: #selector(self.saveButtomClick(_:)), for: .touchUpInside)
        self.view.addSubview(self.saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.leading.trailing.equalTo(self.titleTextView)
            make.height.equalTo(60)
        }
        
        //할 일 했는지 부분
        self.completedSeg.selectedSegmentIndex = self.listItem.completed ? 1 : 0
        
        self.view.addSubview(self.completedSeg)
        
        completedSeg.snp.makeConstraints { make in
            make.bottom.equalTo(self.saveButton.snp.top).offset(-30)
            make.leading.trailing.equalTo(self.saveButton)
            make.height.equalTo(50)
        }
        
        //설명 부분
        self.descriptionTextView.text = self.listItem.description
        
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.descriptionTextView)
        
        descriptionLabel.snp.makeConstraints { make in
            self.keyboardHeightConstTopDes = make.top.equalTo(self.titleTextView.snp.bottom).offset(30).constraint
            make.leading.trailing.equalTo(self.titleTextView)
            make.height.equalTo(40)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(10)
            self.keyboardHeightConstBottomDes = make.bottom.equalTo(self.completedSeg.snp.top).offset(-30).constraint
            make.leading.trailing.equalTo(self.descriptionLabel)
        }
    }
}

extension DetailToDoListView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == self.descriptionTextView {
            self.isSelectDescriptionTextView = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.descriptionTextView {
            self.isSelectDescriptionTextView = false
        }
    }
}
