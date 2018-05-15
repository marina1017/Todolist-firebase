//
//  ListTableViewCell.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/15.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import Foundation
import UIKit

class ListTableViewCell: UITableViewCell {
    
    var dateLabel: UILabel!
    var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCellData(date: Date, content: String) {
        dateLabel.text = getString(from: date)
        contentLabel.text = content
    }
    
    private func getString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
}
