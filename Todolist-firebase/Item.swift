//
//  Item.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/15.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Item {
    var ref: DatabaseReference?
    var title: String?
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        let date = snapshot.value as! Dictionary<String, String> // swiftlint:disable:this force_cast
        title = date["title"]! as String
    }
}
