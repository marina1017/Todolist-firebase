//
//  ListTableViewCell.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/15.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import UIKit
import SnapKit

class ListTableViewCell: UITableViewCell {
    //MARK: Properties
    var contentLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    var postDateLable: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).inset(20)
            make.right.equalTo(self).inset(20)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.postDateLable)
        self.postDateLable.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentLabel).offset(20)
            make.left.equalTo(self).inset(20)
            make.right.equalTo(self).inset(20)
            make.height.equalTo(20)
        }
    }
    
    func setCellData(date: Date, content: String) {
        self.postDateLable.text = self.getString(from: date)
        self.contentLabel.text = content
    }
    
    private func getString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
}
