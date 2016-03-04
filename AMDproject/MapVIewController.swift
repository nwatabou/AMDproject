//
//  MapVIewController.swift
//  AMDproject
//
//  Created by 仲西 渉 on 2016/03/04.
//  Copyright © 2016年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class MapViewController: UIViewController{
    @IBOutlet weak var imageVIew: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImage(named: "map.png")
        imageVIew.image = img
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}