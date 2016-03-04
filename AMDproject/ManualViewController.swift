//
//  ManualViewController.swift
//  AMDproject
//
//  Created by 仲西 渉 on 2016/03/01.
//  Copyright © 2016年 nwatabou. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ManualViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mainImageVIew: UIImageView!

    
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
    var beaconNo = 0
    
    var count = 0
    
    var i = 0
    
    //image[種類][写真番号]で参照可
    let image = ["","ceiling","door","karesansui","glass","kusunoki","ranma","spikeReason","spikeHidden","water"]
    
    let extention = ".png"
    
    let mapImg = UIImage(named: "map.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //起動したらHome画面で位置情報の許可を得る
        // ロケーションマネージャを作成する
        self.trackLocationManager = CLLocationManager()
        
        // デリゲートを自身に設定
        self.trackLocationManager.delegate = self
        
        // BeaconのUUIDを設定
        let uuid:NSUUID? = NSUUID(UUIDString: "00000000-7DE6-1001-B000-001C4DF13E76")
        
        //Beacon領域を作成
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "net.noumenon-th")
        
        self.mainImageVIew.image = mapImg
    }
    
    //位置認証のステータスが変更された時に呼ばれる
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        // 認証のステータス
        let statusStr = ""
        print("CLAuthorizationStatus: \(statusStr)")
        
        
        print(" CLAuthorizationStatus: \(statusStr)")
        
        //観測を開始させる
        trackLocationManager.startMonitoringForRegion(self.beaconRegion)
    }
    
    
    
    
    //観測の開始に成功すると呼ばれる
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        
        print("didStartMonitoringForRegion")
        
        //観測開始に成功したら、領域内にいるかどうかの判定をおこなう。→（didDetermineState）へ
        trackLocationManager.requestStateForRegion(self.beaconRegion)
    }
    
    
    
    
    //領域内にいるかどうかを判定する
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion inRegion: CLRegion) {
        
        switch (state) {
            
        case .Inside: // すでに領域内にいる場合は（didEnterRegion）は呼ばれない
            
            trackLocationManager.startRangingBeaconsInRegion(beaconRegion);
            // →(didRangeBeacons)で測定をはじめる
            break;
            
        case .Outside:
            
            // 領域外→領域に入った場合はdidEnterRegionが呼ばれる
            break;
            
        case .Unknown:
            
            // 不明→領域に入った場合はdidEnterRegionが呼ばれる
            break;
        }
    }
    
    
    
    
    //領域に入った時
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        // →(didRangeBeacons)で測定をはじめる
        self.trackLocationManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    
    
    
    
    //領域から出た時
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        //測定を停止する
        self.trackLocationManager.stopRangingBeaconsInRegion(self.beaconRegion)
    }
    
    
    
    //領域内にいるので測定をする
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion){
        let beacon = beacons[0]

        beaconNo = (beacon.minor).integerValue
        count += 1
        
        
        if(beacon.proximity == CLProximity.Immediate || beacon.proximity == CLProximity.Near || beacon.proximity == CLProximity.Far){
            i = 0
            beaconNo = (beacon.minor).integerValue
            changeImage()
        }else{
            i += 1
        }
    }

    
        
        /*
        //圏外になって3カウント経ったらリセット
        if(beacon.proximity == CLProximity.Unknown){
            self.minor.text = "none"
            i += 1
            //圏外以外の状態の時
        }else{
            i = 0
            beaconNo = (beacon.minor).integerValue
            changeImage()
*/
            
//            let mainImage = UIImage(named: image[(beacon.minor).integerValue] + extention)
//            self.mainImageVIew.image = mainImage
            /*
            i = 0
            count += 1
            //1回だけ変更
            if(count == 2){
                beaconNo = (beacon.minor).integerValue
            }
            //3カウント観測をキープしたら安定＝画像変更
            if(count > 2){
                if(beaconNo == (beacon.minor).integerValue){
                    let mainImage = UIImage(named: image[beaconNo] + extention)
                    self.mainImageVIew.image = mainImage
                }else{
                    count = 0
                }
            }
*/
//        }
//}
    
    func changeImage(){
        let mainImage = UIImage(named: image[beaconNo] + extention)
        self.mainImageVIew.image = mainImage
    }

    
    func recet(){
        self.mainImageVIew.image = mapImg
        count = 0
        i = 0
        print("recet")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}