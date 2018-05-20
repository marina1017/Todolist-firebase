//
//  AuthModel.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/19.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import Firebase

@objc protocol AuthModelDelegate: class {
    @objc optional func didSignUp(newUser: User)
    @objc optional func didLogIn(isEmailVerified: Bool)
    @objc optional func emailVerificationDidSend()
    func errorDidOccur(error: Error)
}

class AuthModel {
    weak var delegate: AuthModelDelegate?
    
    func signUp(with email: String, and password: String) {
        //emailとpasswordでユーザーを作成
        Auth.auth().createUser(withEmail: email, password: password, completion: { [unowned self] (user, error) in
            if let error = error {
                self.delegate?.errorDidOccur(error: error)
                return
            }
            guard let user = user else { return }
            self.delegate?.didSignUp?(newUser: user)
        })
    }
    func sendEmailVerification(to user: User) {
        //ユーザーにアドレス確認メールを送信できるメソッド
        user.sendEmailVerification() { [unowned self] error in
            if let error = error {
                self.delegate?.errorDidOccur(error: error)
                return
            }
            self.delegate?.emailVerificationDidSend?()
        }
    }
    func login(with email: String, and password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            guard let _ = user else {
                if let error = error {
                    self.delegate?.errorDidOccur(error: error)
                    return
                }
                return
            }
            guard let user = user else {return}
            self.delegate?.didLogIn?(isEmailVerified: user.isEmailVerified)
        })
    }
    
}
