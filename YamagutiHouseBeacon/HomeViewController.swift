//
//  HomeViewController.swift
//  YamagutiHouseBeacon
//
//  Created by 仲西 渉 on 2016/02/10.
//  Copyright © 2016年 nwatabou. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    //ボタンを押すとスタート
    @IBAction func nextButton(sender: AnyObject) {
        let mainViewController = self.storyboard!.instantiateViewControllerWithIdentifier("main")
        self.presentViewController(mainViewController, animated: true, completion: nil)
    }
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //起動したらHome画面で位置情報の許可を得る
        // ロケーションマネージャを作成する
        self.trackLocationManager = CLLocationManager();
        
        // デリゲートを自身に設定
        self.trackLocationManager.delegate = self;
        
        // セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示
        if(status == CLAuthorizationStatus.NotDetermined) {
            
            self.trackLocationManager.requestAlwaysAuthorization();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}