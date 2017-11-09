//
//  SquareItemViewController.swift
//  ClueSwiftDemo
//
//  Created by maomao on 2017/10/26.
//  Copyright © 2017年 maomao. All rights reserved.
//

import Foundation
import SnapKit
import UIKit
import SKPhotoBrowser

@objc class SquareItemViewController: BaseViewController ,HJImageBrowserDelegate{
    
    let identyfierTable1 = "SquareTableViewCell"
    
    var theImage = UIImage()
    var theIndex = 1000
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.randomColor
        configSubViews()
    }
    
     func configSubViews() {
        
        var mainTableView = UITableView()
        //    数据源
        //var mainTableArr = NSMutableArray()
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "SquareTableViewCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        self.view.addSubview(mainTableView)
    }
    
    //    #MARK:HJImageBrowserDelegate
    func getTheThumbnailImage(_ indexRow: Int) -> UIImage {
        
        //        点击图片之后，放大过程中显示的那张图片
        return theImage
    }
}

extension   SquareItemViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SquareTableViewCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! SquareTableViewCell
        cell.selectionStyle = .default
        
       // let num  = 0
        
        var num = Int(arc4random_uniform(6))+1
        if num == 1 {
            num = 0
        }

        if indexPath.row == 0 {
            num = 8
        }
        
        
        cell.assignToViews(num: num)
        
        cell.showImageAction = {
            
            self.theImage = $2
            self.theIndex = $0

            let bview = HJImageBrowser()

            bview.delegate = self

            //  bottomView 是点击的imageView的直接父视图
            //  在Xib里面设置的
            bview.bottomView = cell.viewWithTag(10086)

            //            当前点击的图片在该数组中的位置。
            bview.indexImage = $0

            bview.defaultImage = $2

            bview.arrayImage = $1 as! [String]

            bview.show()
            
            //2. 用SKPhotoBrowser
            
          //   1. create URL Array
//            var images = [SKPhoto]()
//            let photo = SKPhoto.photoWithImageURL("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558288&di=2f1438a523984a5c8ee8f9d92714383a&imgtype=0&src=http%3A%2F%2Fimg4q.duitang.com%2Fuploads%2Fitem%2F201502%2F15%2F20150215230510_FCHPA.jpeg")
//            photo.shouldCachePhotoURLImage = false // you can use image cache by true(NSCache)
//            images.append(photo)
//
//           //  2. create PhotoBrowser Instance, and present.
//            let browser = SKPhotoBrowser(photos: images)
//            browser.initializePageIndex($0)
//            SquareItemViewController(browser, animated: true, completion: {})
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

























