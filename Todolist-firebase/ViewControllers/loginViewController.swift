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
    
    var authModel = AuthModel()
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
        button.addTarget(self,
                         action: #selector(LoginViewController.loginButtonTapped(sender:)),
                         for: .touchUpInside)
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
        //FIRAuthは→Authにする
        
        if Auth.auth().currentUser != nil {
            self.toList()
        } else {
            
        }
        self.initializeUI()
        self.initializeModel()
        
        
    }
    func initializeUI() {
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
    func initializeModel() {
        authModel = AuthModel()
        authModel.delegate = self
    }
    @objc func loginButtonTapped(sender: AnyObject) {
        guard let email = self.mailField.text else { return }
        guard let password = self.passwordField.text else { return }
        authModel.login(with: email, and: password)
    }
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "To Do App", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    func toList() {
        let listViewController = ListViewController()
        //UINavigationControllerにrootViewControllerにしたい、viewControllerを入れてインスタンスを作成
        let navigationController = UINavigationController(rootViewController: listViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    @objc func buttonTapped(sender : AnyObject) {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true, completion: nil)
       
    }
    func presentValidateAlert() {
        let alert = UIAlertController(title: "メール認証", message: "メール認証を行ってください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController: AuthModelDelegate {
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
    func didLogIn(isEmailVerified: Bool) {
        if isEmailVerified {
            self.toList()
        } else {
            self.presentValidateAlert()
        }
    }
}
