//
//  signUpViewController.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/11.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import Foundation
import SnapKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    let mailField: UITextField = {
        //インスタンス作成
        let mailField = UITextField()
        // 表示する文字を代入する.
        mailField.placeholder = "Email"
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
        passwordField.placeholder = "パスワード"
        // 枠を表示する.
        passwordField.borderStyle = .roundedRect
        // クリアボタンを追加.
        passwordField.clearButtonMode = .whileEditing
        return passwordField
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("登録", for: UIControlState.normal)
//        // タップされたときのaction
        button.addTarget(self,
                         action: #selector(SignUpViewController.signUpButtonTapped(sender:)),
                         for: .touchUpInside)
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "アカウントをもっている場合は"
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = UIColor.blue
        button.setTitle("ログイン", for: UIControlState.normal)
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
        
        if let _ = Auth.auth().currentUser {
            
        }
        
        //Appdelegateから遷移する時背景色が必要
        self.view.backgroundColor = UIColor.white
        
        // Delegateを自身に設定する
        self.mailField.delegate = self
        // Delegateを自身に設定する
        self.passwordField.delegate = self
        
        stackView.addArrangedSubview(self.label)
        stackView.addArrangedSubview(self.loginButton)
        
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
        self.view.addSubview(signInButton)
        signInButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        // Viewに追加する
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }
        
    }
    @objc func signUpButtonTapped(sender: AnyObject) {
        let email = self.mailField.text
        let password = self.passwordField.text
        //emailとpasswordでユーザーを作成
        Auth.auth().createUser(withEmail: email!, password: password!, completion: {(user, error) in
            print("☆user:",user,"☆error" ,error)
            if let error = error {
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.showAlert("有効なメールアドレスを入力してください。")
                    case .emailAlreadyInUse:
                        self.showAlert("すでに使用中のメールです")
                    default:
                        self.showAlert("エラー: \(error.localizedDescription)")
                    }

                }
                return

            }
            self.signIn()
        })

    }
    @objc func buttonTapped(sender: AnyObject) {
        let loginViewController = LoginViewController()
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "お願い", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "もどる", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func signIn() {
        let loginViewController = LoginViewController()
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
