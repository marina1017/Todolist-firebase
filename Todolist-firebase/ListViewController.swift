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
    //`FIRFirestore` は Firestore Database を表しFirestoroperationsのエントリーポイントである
    let db = Firestore.firestore()
    
    var contentArray: [DocumentSnapshot] = []
    var selectedSnapshot: DocumentSnapshot?
    
    var listner: ListenerRegistration?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
        self.inittializeUI()
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
        self.navigationItem.title = "title font test"
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(ListViewController.pushButton(sender:)))
        self.navigationItem.setRightBarButton(barButton, animated: true)
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
    
    
    @objc func pushButton(sender: AnyObject) {
        selectedSnapshot = nil
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    //行数 セクションによって行数が違う場合はsectionで場合分けをするUITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //列ごとに表示するセルを決めるデリゲートメソッド
    //UITableViewDataSource は主に Table View が表示するデータを与えるものです。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルを取得するメソッド
        // Identifier はどの型セルを再利用または作成するかを決めるものです。
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ListTableViewCell.self), for: indexPath) as? ListTableViewCell else {
//            fatalError("The dequeued cell is not instance of MealTableViewCell.")
            return UITableViewCell()
//        }
//        let content = contentArray[indexPath.row]
//        //        let date = content["date"] as! Date
//        if let date = content["date"] as? Date {
//            cell.setCellData(date: date, content: String(describing: content["content"]!))
//            return cell
//        }
//        return UITableViewCell()
    }
    
    //TableViewの条件付き編集をサポートする関数　指定した項目を編集可能にしたい場合はtrueを返す
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}
