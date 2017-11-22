//
//  HomeViewCOnrroller.swift
//  ClueSwiftDemo
//
//  Created by maomao on 2017/10/26.
//  Copyright © 2017年 maomao. All rights reserved.
//

import Foundation
import UIKit

private let cellID = "HomeCell"

class HomeViewController: BaseViewController {
    
    fileprivate lazy var headView : XRCarouselView = {[weak self] in
        
        let headView = XRCarouselView()
        headView.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 150)
        headView.time = 3.0
        headView.pagePosition = PositionBottomCenter
        headView.delegate = self
        return headView
    }()
    
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame:CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH-64))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .singleLine
//        tableView.estimatedRowHeight = 100.0
//        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.tableHeaderView = headView
        let imageArr = ["https://i7.pdim.gs/88e403794a2f8fef7f883831e74d168e.jpeg","http://i8.pdim.gs/ba87eb…2cb6538cefb0f47aa7.jpeg","http://i7.pdim.gs/309332d9cd2acba55d5da0abf26578d9.jpeg","http://i9.pdim.gs/9214a37f91740f75b6d61eed7ebd3076.jpeg","http://i7.pdim.gs/ec49cafffb1455de51da18cd3d2daf72.jpeg","http://itunes.apple.com/cn/app/id884513234?mt=8"]
        headView.imageArray = imageArr
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController:XRCarouselViewDelegate{
    
    func carouselView(_ carouselView: XRCarouselView!, didClickImage index: Int) {
        
    }
}

extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? HomeCell
        cell?.contentLabel.text = "啊我的拉屎爱上啦开发阿拉胡康师傅爱上啦客户端啊是来打开大哈伦裤阿斯达了好快阿斯达了好快爱上啦好看阿斯达哈伦裤啊是离开阿斯达哈伦裤啊是离开爱上啦好看的阿里山付货款啊我的拉屎爱上啦开发阿拉胡康师傅爱上啦客户端啊是来打开大哈伦裤阿斯达了好快阿斯达了好快爱上啦好看阿斯达哈伦裤啊是离开阿斯达哈伦裤啊是离开爱上啦好看的阿里山付货款"
        cell?.iconImageView.image = UIImage.init(named: "user")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
//     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


