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

class PostViewController: UIViewController,UITextFieldDelegate{

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
                         action: #selector(LoginViewController.loginButtonTapped(sender:)),
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
        self.textField.delegate = self
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
    
    func inittializeUI() {
        self.view.backgroundColor = UIColor.white
        // タイトルをセット
        self.navigationItem.title = "toDo追加"
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(PostViewController.closeButton(sender:)))
        self.navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    @objc func closeButton(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }


}
