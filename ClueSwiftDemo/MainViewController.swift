//
//  MainViewController.swift
//  ClueSwiftDemo
//
//  Created by maomao on 2017/10/26.
//  Copyright © 2017年 maomao. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
    
    fileprivate let titles:[String] = ["首页","广场","","公告","我的"]
    fileprivate let normalImgNames:[String] = ["home","square","publish","announcement","my"]
    fileprivate let selectedImgNames:[String] = ["home_click","square_click","publish","announcement_click","my_click"]
    fileprivate let VCs:[UIViewController] = [HomeViewController(),SquareViewController(),BrokeViewController(),NoticeViewController(),MineViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
}

extension MainViewController{
    
    fileprivate func setUpUI(){
        for item in 0..<titles.count {
            
            let vc = VCs[item]
            vc.tabBarItem.image = UIImage.init(named: normalImgNames[item])?.withRenderingMode(.alwaysOriginal)
            vc.tabBarItem.selectedImage = UIImage.init(named: selectedImgNames[item])?.withRenderingMode(.alwaysOriginal)
            vc.tabBarItem.title = titles[item]
            let navc = UINavigationController.init(rootViewController:vc)
            vc.navigationItem.title = titles[item]
            self.addChildViewController(navc)
        }
    }
}


























