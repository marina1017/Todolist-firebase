//
//  ViewController.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/07.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        let mailField = UITextField()
        // 表示する文字を代入する.
        mailField.placeholder = "mailField"
        // Delegateを自身に設定する
        mailField.delegate = self
        // 枠を表示する.
        mailField.borderStyle = .roundedRect
        // クリアボタンを追加.
        mailField.clearButtonMode = .whileEditing
        
        let passwordField = UITextField()
        // 表示する文字を代入する.
        passwordField.placeholder = "pwField"
        // Delegateを自身に設定する
        passwordField.delegate = self
        // 枠を表示する.
        passwordField.borderStyle = .roundedRect
        // クリアボタンを追加.
        passwordField.clearButtonMode = .whileEditing
        
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
            //stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(signUpButton)
        stackView.spacing = 10
        
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

