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
    var postModel: PostModel!
    let label: UILabel = {
        let label = UILabel()
        label.text = "todoリスト"
        return label
    }()
    let postButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("登録", for: UIControlState.normal)
        button.addTarget(self,
                         action: #selector(PostViewController.postButtonTapped(sender:)),
                         for: .touchUpInside)
        return button
    }()
    let textField: UITextField = {
        //インスタンス作成
        let mailField = UITextField()
        // 表示する文字を代入する.
        mailField.placeholder = "メールする"
        // 枠を表示する.
        mailField.borderStyle = .roundedRect
        // クリアボタンを追加.
        mailField.clearButtonMode = .whileEditing
        return mailField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
        self.initializeModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let post = postModel.selectedPost {
            textField.text = post.content
        }
    }
    @objc func postButtonTapped(sender: UIButton) {
        guard let content = textField.text else { return }
        postModel.post(with: content)
    }
    @objc func closeButton(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "To Do App", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    func initializeModel() {
        if postModel == nil {
            postModel = PostModel()
        }
        postModel.delegate = self
    }
    func initializeUI() {
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
}

extension PostViewController: PostModelDelegate {
    func didPost() {
        print("Document added")
        dismiss(animated: true, completion: nil)
    }
    func errorDidOccur(error: Error) {
        if let errCode = AuthErrorCode(rawValue: error._code) {
            //ここ公式と異なる 参考(https://code.i-harness.com/ja/q/23b70bf)
            switch errCode {
            case .invalidEmail:
                self.showAlert("User account not found. Try registering")
            case .wrongPassword:
                self.showAlert("Incorrect username/password combination")
            default:
                self.showAlert("Error:\(error.localizedDescription)")
            }
        }
    }
}

extension PostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
