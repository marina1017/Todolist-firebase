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
    var nameLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).inset(20)
            make.right.equalTo(self).inset(20)
            make.height.equalTo(40)
        }
        
    }
    
    //MARK : method
    private func commonInit() {
        self.createNameLabel()
    }
    private func createNameLabel() {
        nameLabel = UILabel(frame: CGRect.zero)
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 20)
    }
    

}
