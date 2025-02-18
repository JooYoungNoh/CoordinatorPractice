//
//  ToDoListCell.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/09.
//

import UIKit
import SnapKit

class ToDoListCell: UITableViewCell {
    static let identifier = "ToDoListCell"
    
    lazy var stackView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionData: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var completedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
       
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(self.stackView)
        
        self.stackView.addSubview(completedImage)
        self.stackView.addSubview(title)
        self.stackView.addSubview(descriptionData)
        
        self.stackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        self.completedImage.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top).offset(10)
            make.trailing.equalTo(stackView.snp.trailing).offset(-20)
            make.width.height.equalTo(30)
        }
        
        self.title.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top).offset(10)
            make.leading.equalTo(stackView.snp.leading).offset(20)
            make.trailing.equalTo(completedImage.snp.leading).offset(-10)
            make.height.equalTo(30)
        }
        
        self.descriptionData.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.bottom.equalTo(stackView.snp.bottom).offset(-10)
            make.leading.equalTo(title)
            make.trailing.equalTo(completedImage)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.title.text = ""
        self.descriptionData.text = ""
        self.completedImage.isHidden = true
    }
}
