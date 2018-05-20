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
    let listModel = ListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
        self.inittializeUI()
        self.initializeModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listModel.selectedSnapshot = nil
    }
    @objc func pushButton(sender: AnyObject) {
        self.toPost()
    }
    func initializeModel() {
        self.listModel.delegate = self
        self.listModel.read()
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
        //行き先のviewControllerを示す
        if let snap = listModel.selectedSnapshot {
            let postModel = PostModel(with:
                Post(
                    id: snap.documentID,
                    user: snap["user"] as! String,
                    content: snap["content"] as! String,
                    date: snap["date"] as! Date
                )
            )
            postViewController.postModel = postModel
        }
        self.present(navigationController, animated: true)
    }
}
extension ListViewController: ListModelDelegate {
    func listDidChange() {
        self.tableView.reloadData()
    }
    
    func errorDidOccur(error: Error) {
        print(error.localizedDescription)
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
        return listModel.contentArray.count
    }
    //列ごとに表示するセルを決めるデリゲートメソッド
    //UITableViewDataSource は主に Table View が表示するデータを与えるものです。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ListTableViewCell.self), for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        let content = listModel.contentArray[indexPath.row]
        let date = content["date"] as! Date // swiftlint:disable:this force_cast
        cell.setCellData(date: date, content: String(describing: content["content"]!))
        return cell
    }
    
    //TableViewの条件付き編集をサポートする関数　指定した項目を編集可能にしたい場合はtrueを返す
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        listModel.selectedSnapshot = listModel.contentArray[indexPath.row]
        self.toPost()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listModel.delete(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        }
    }
}
