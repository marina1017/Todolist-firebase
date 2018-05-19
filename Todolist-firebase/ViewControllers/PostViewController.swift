//
//  File.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/19.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PostViewController: UIViewController {
    //データベースの設定
    let db = Firestore.firestore()
    
    var selectedSnapShot: DocumentSnapshot?

    let label: UILabel = {
        let label = UILabel()
        label.text = "todoリスト"
        return label
    }()

    let postButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("ログイン", for: UIControlState.normal)
        button.addTarget(self,
                         action: #selector(PostViewController.postButtonTapped(sender:)),
                         for: .touchUpInside)
        return button
    }()

    let textField: UITextField = {
        //インスタンス作成
        let mailField = UITextField()
        // 表示する文字を代入する.
        mailField.placeholder = "mailField"
        // 枠を表示する.
        mailField.borderStyle = .roundedRect
        // クリアボタンを追加.
        mailField.clearButtonMode = .whileEditing
        return mailField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inittializeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let snapshot = self.selectedSnapShot {
            textField.text = snapshot["content"] as? String
        }
    }
    
    @objc func postButtonTapped(sender: UIButton) {
        if self.selectedSnapShot != nil {
            self.update()
            
        } else {
            self.create()
        }
    }
    
    func update() {
        self.db.collection("posts").document(selectedSnapShot!.documentID).updateData([
            "content": self.textField.text!,
            "date": Date()
        ]){ [unowned self] error in
            if let e = error {
                print("Error adding document: \(e)")
                return
            }
            print("Document updated")
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func create() {
        guard let text = self.textField.text else { return }
        
        db.collection("posts").addDocument(data: [
            "user": (Auth.auth().currentUser?.uid),
            "content": text,
            "date": Date()
        ]){ [unowned self] error in
            if let e = error {
                print("Error adding document: \(e))")
                return
            }
            print("Document added")
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func inittializeUI() {
        self.textField.delegate = self
        self.view.backgroundColor = UIColor.white
        // タイトルをセット
        self.navigationItem.title = "toDo追加"
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(PostViewController.closeButton(sender:)))
        self.navigationItem.setRightBarButton(barButton, animated: true)
        // Viewに追加する
        self.view.addSubview(self.label)
        self.label.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(60)
            make.left.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        // Viewに追加する
        self.view.addSubview(self.textField)
        self.textField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.label.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        // Viewに追加する
        self.view.addSubview(self.postButton)
        self.postButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.textField.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    
    @objc func closeButton(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
