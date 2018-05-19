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
    
    let db = Firestore.firestore()
    
    var contentArray: [DocumentSnapshot] = []
    var selectedSnapshot: DocumentSnapshot?
    
    var listner: ListenerRegistration?
    
//    var user: User!
//    var items = [Item]()
//    var ref: DatabaseReference!
//    private var databaseHandle: DatabaseHandle!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
        self.inittializeUI()
        self.read()
        
        
//        //ユーザーのログイン時の情報をuserにセット
//        self.user = Auth.auth().currentUser
//        //Firebaseデータベースのルート
//        ref = Database.database().reference()
//        startObservingDatabase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initializeTableView(){
        //テーブルビュー
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 100
        //NSStrignFromClassはクラスの名前をStringで返してくれる
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(ListTableViewCell.self))
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
    
    func read() {
        //オフライン データをリッスンする
        //https://firebase.google.com/docs/firestore/manage-data/enable-offline?hl=ja
        //Query.onSnapshot（）で使用してスナップショットリスナの動作を制御するためのオプション。
        let options = QueryListenOptions()
        //fromCache 値を使用する場合には、リッスン ハンドラを接続するときに includeMetadataChanges リッスン オプションを指定します。
        //FIRQuerySnapshot.metadataが更新された場合スナップショットイベントをおこすかデフォルトはFalse
        options.includeQueryMetadataChanges(true)
        
        //このへんよくわからない
        listner = db.collection("posts").order(by: "date")
            .addSnapshotListener(options: options) { [unowned self] snapshot, error in
                guard let snap = snapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                for diff in snap.documentChanges {
                    if diff.type == .added {
                        print("New data: \(diff.document.data())")
                    }
                }
                print("Current data: \(snap)")
                self.reload(with: snap)
        }
    }
    
    func reload(with snap: QuerySnapshot) {
        if !snap.isEmpty {
            contentArray.removeAll()
            for item in snap.documents {
                contentArray.append(item)
            }
            self.tableView.reloadData()
        }
    }
    
    func delete(deleteIndexPath indexPath: IndexPath) {
        db.collection("posts").document(contentArray[indexPath.row].documentID).delete()
        contentArray.remove(at: indexPath.row)
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
    
    func toPost() {
        let postViewController = PostViewController()
        let navigationController = UINavigationController(rootViewController: postViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func pushButton(sender: AnyObject) {
//        let prompt = UIAlertController(title: "To Do App", message: "To Do Item", preferredStyle:.alert)
//        let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
//            let userInput = prompt.textFields![0].text
//            if (userInput!.isEmpty) {
//                return
//            }
//            self.ref.child("users").child(self.user.uid).child("items").childByAutoId().child("title").setValue(userInput)
//        }
//        prompt.addTextField(configurationHandler: nil)
//        prompt.addAction(okAction)
//        present(prompt, animated: true, completion: nil)
        selectedSnapshot = nil
        self.toPost()
    }
    
    //データベースに加えられた変更も検知するリスナーをセット
    //初期値取得のために一度呼び出されデータに変更がある度に呼ばれる
//    func startObservingDatabase() {
//        //.value
//        //FIRDataEventTypeValue：そのパスにあるコンテンツ全体の変更の検知と読み取りをする
//        //FIRDataEventTypeValueイベントは参照するデータベースのデータが変更されると、子要素の変更も含めて毎回実行される
//        databaseHandle = ref.child("users/\(self.user.uid)/items").observe(.value, with: { (snapshot) in
//            var newItems = [Item]()
//            for ItemSnapShot in snapshot.children {
//                if let itemSnapShot = ItemSnapShot as? DataSnapshot {
//                    let item = Item(snapshot: itemSnapShot)
//                    newItems.append(item)
//                }
//            }
//            self.items = newItems
//            self.tableView.reloadData()
//        })
//    }
    
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
        return contentArray.count
    }
    //列ごとに表示するセルを決めるデリゲートメソッド
    //UITableViewDataSource は主に Table View が表示するデータを与えるものです。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ListTableViewCell.self), for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        let content = contentArray[indexPath.row]
        let date = content["date"] as! Date // swiftlint:disable:this force_cast
        cell.setCellData(date: date, content: String(describing: content["content"]!))
        return cell
    }
    
    //TableViewの条件付き編集をサポートする関数　指定した項目を編集可能にしたい場合はtrueを返す
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSnapshot = contentArray[indexPath.row]
        self.toPost()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.delete(deleteIndexPath: indexPath)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        }
    }

}
