//
//  ViewController.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/07.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    let mailField: UITextField = {
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
    
    let passwordField: UITextField = {
        //インスタンス作成
        let passwordField = UITextField()
        // 表示する文字を代入する.
        passwordField.placeholder = "pwField"
        // 枠を表示する.
        passwordField.borderStyle = .roundedRect
        // クリアボタンを追加.
        passwordField.clearButtonMode = .whileEditing
        return passwordField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("ログイン", for: UIControlState.normal)
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "アカウントを持っていない場合"
        return label
    }()
    let signUpButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = UIColor.blue
        button.setTitle("登録", for: UIControlState.normal)
        button.setTitleColor(UIColor.blue, for: UIControlState.normal)
        // タップされたときのaction
        button.addTarget(self,
                         action: #selector(LoginViewController.buttonTapped(sender:)),
                         for: .touchUpInside)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Appdelegateから遷移する時背景色が必要
        self.view.backgroundColor = UIColor.white
        
        self.stackView.addArrangedSubview(label)
        self.stackView.addArrangedSubview(signUpButton)
        // Delegateを自身に設定する
        self.mailField.delegate = self
        // Delegateを自身に設定する
        self.passwordField.delegate = self

        
        
        // Viewに追加する
        self.view.addSubview(mailField)
        mailField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(60)
            make.left.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        // Viewに追加する
        self.view.addSubview(passwordField)
        passwordField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mailField.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        // Viewに追加する
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        // Viewに追加する
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }
        
    }
    
    @objc func buttonTapped(sender : AnyObject) {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true, completion: nil)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

