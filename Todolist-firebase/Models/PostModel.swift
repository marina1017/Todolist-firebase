//
//  PostModel.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/19.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import Foundation
import Firebase

struct Post {
    var id: String
    var user: String
    var content: String
    var date: Date
}

protocol PostModelDelegate: class {
    func didPost()
    func errorDidOccur(error: Error)
}

class PostModel {
    let db: Firestore
    weak var delegate: PostModelDelegate?
    
    let selectedPost: Post?
    
    init(with selectedPost: Post? = nil) {
        self.selectedPost = selectedPost
        self.db = Firestore.firestore()
        //ローカルの永続的なストレージを有効にする
        db.settings.isPersistenceEnabled = true
    }
    
    func post(with content: String) {
        if let post = selectedPost {
            db.collection("posts").document(post.id).updateData([
                "content": content,
                "date":Date()
            ]) { [unowned self] error in
                if let error = error {
                    self.delegate?.errorDidOccur(error: error)
                    return
                }
                self.delegate?.didPost()
            }
        } else {
            db.collection("posts").addDocument(data: [
                "user": (Auth.auth().currentUser?.uid),
                "content": content,
                "date": Date()
            ]) { [unowned self] error in
                if let error = error {
                    self.delegate?.errorDidOccur(error: error)
                    return
                }
                self.delegate?.didPost()
            }
        }
    }
    
    
}
