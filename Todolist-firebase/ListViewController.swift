//
//  ListViewController.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/13.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController{
    var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        //テーブルビュー
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.rowHeight = 100
        self.view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
    }
    //行数 セクションによって行数が違う場合はsectionで場合分けをするUITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    //列ごとに表示するセルを決めるデリゲートメソッド
    //UITableViewDataSource は主に Table View が表示するデータを与えるものです。
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
    //TableViewの条件付き編集をサポートする関数　指定した項目を編集可能にしたい場合はtrueを返す
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
