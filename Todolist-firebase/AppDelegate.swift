//
//  AppDelegate.swift
//  Todolist-firebase
//
//  Created by 中川万莉奈 on 2018/05/07.
//  Copyright © 2018年 中川万莉奈. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //アプリのインターフェースの背景
    //windowはイベントを制御し、アプリを制御する基本となるたくさんのタスクを実行する
    var window: UIWindow?

    // 起動した直後に走る関数
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Firebaseを使うのに必要（チュートリアルで入れるように言われる）
        FirebaseApp.configure()
        return true
    }
    //アプリケーションがアクティブな状態にになる直前
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    //アプリケーションがアクティブな状態でバックグラウンドになった直後
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    //アプリケーションがアクティブな状態でフォアグラウンドになった直後
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    //アプリケーションがアクティブな状態になる直後
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    //アプリケーションが終了する直前
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

