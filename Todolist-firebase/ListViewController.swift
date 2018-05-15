//
//  ListViewController.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/13.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ListViewController: UIViewController {
    var tableView = UITableView()
    
    var user: User!
    var items = [Item]()
    var ref: DatabaseReference!
    private var databaseHandle: DatabaseHandle!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
        self.inittializeUI()
        //ユーザーのログイン時の情報をuserにセット
        self.user = Auth.auth().currentUser
        //Firebaseデータベースのルート
        ref = Database.database().reference()
        startObservingDatabase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initializeTableView(){
        //テーブルビュー
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    func inittializeUI() {
        self.view.backgroundColor = UIColor.white
        // タイトルをセット
        self.navigationItem.title = "toDoリスト"
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(ListViewController.pushButton(sender:)))
        self.navigationItem.setRightBarButton(barButton, animated: true)
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @objc func didTapSignOut(sender: AnyObject) {
        do {
            //FIRAuth→Auth
            try Auth.auth().signOut()
            performSegue(withIdentifier: "SignOut", sender: nil)
        } catch let error {
            assertionFailure("Error signing out: \(error)")
        }
    }
    
    @objc func pushButton(sender: AnyObject) {
        let prompt = UIAlertController(title: "To Do App", message: "To Do Item", preferredStyle:.alert)
        let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            self.ref.child("users").child(self.user.uid).child("items").childByAutoId().child("title").setValue(userInput)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }
    
    //データベースに加えられた変更も検知するリスナーをセット
    //初期値取得のために一度呼び出されデータに変更がある度に呼ばれる
    func startObservingDatabase() {
        //.value
        //FIRDataEventTypeValue：そのパスにあるコンテンツ全体の変更の検知と読み取りをする
        //FIRDataEventTypeValueイベントは参照するデータベースのデータが変更されると、子要素の変更も含めて毎回実行される
        databaseHandle = ref.child("users/\(self.user.uid)/items").observe(.value, with: { (snapshot) in
            var newItems = [Item]()
            for ItemSnapShot in snapshot.children {
                if let itemSnapShot = ItemSnapShot as? DataSnapshot {
                    let item = Item(snapshot: itemSnapShot)
                    newItems.append(item)
                }
            }
            self.items = newItems
            self.tableView.reloadData()
        })
    }
    
    deinit {
        //ref.child("users/\(self.user.uid)/items").removeObserver(withHandle: databaseHandle)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //セクションの数を設定
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //行数 セクションによって行数が違う場合はsectionで場合分けをするUITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    //列ごとに表示するセルを決めるデリゲートメソッド
    //UITableViewDataSource は主に Table View が表示するデータを与えるものです。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
    
    //TableViewの条件付き編集をサポートする関数　指定した項目を編集可能にしたい場合はtrueを返す
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = items[indexPath.row]
            item.ref?.removeValue()
        }
    }

}
