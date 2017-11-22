//
//  SquareViewController.swift
//  ClueSwiftDemo
//
//  Created by maomao on 2017/10/26.
//  Copyright © 2017年 maomao. All rights reserved.
//

import Foundation
import UIKit

let headerH : CGFloat = 150


class SquareViewController: BaseViewController{
    
    fileprivate let tableView = UITableView()
    fileprivate var canScroll:Bool! = false
    fileprivate var isTopIsCanNotMoveTabView:Bool! = false
    fileprivate var isTopIsCanNotMoveTabViewPre:Bool! = false
    
    lazy var subViewTitles:[String] = {
        
        let array = ["共治","平安","共治","宣传"]
        return array
    }()
    
    
    lazy var HeadView : UIView = {
        let headView = UIView(frame:CGRect.init(x: 0, y: -headerH, width: kScreenW, height: headerH))
        //(x: 0, y: 0, width: kScreenW, height: headerH)
        headView.backgroundColor = UIColor.red
        return headView
    }()
    
    lazy var VCManager:VCManagerView = {
        
        let manager = VCManagerView(frame:CGRect.init(x: 0, y: 0, width: kScreenW, height: 44))
        manager.delegate = self
       // self.view.addSubview(manager)
        return manager
    }()
    
    lazy var pageMagager:PageManagerVC = {
        

        let secondVC = SquareItemViewController()
       // secondVC.delegate = self
        let third = SquareItemViewController()
      //  third.delegate = self
        let four = SquareItemViewController()
      //  four.delegate = self
        
        let manager = PageManagerVC.init(superController: self, childControllerS: [secondVC,UIStoryboard(name: "SquareSecondItemVC", bundle: nil).instantiateInitialViewController() as! SquareSecondItemVC,third,four,SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),])
        manager.view.frame = CGRect(x: 0, y: 44, width: kScreenW, height: kScreenH-64-44)
        manager.delegate = self
       // self.view.addSubview(manager.view)
        return manager
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
       // self.view.addSubview(HeadView)
        configSubViews()
        VCManager.title_font = UIFont.systemFont(ofSize: 15)
        VCManager.sliderWidthType = .ButtonWidth
        VCManager.title_array = subViewTitles
        setConstraint()
        
          NotificationCenter.default.addObserver(self, selector: #selector(acceptMsg(notification:)), name: NSNotification.Name(rawValue: "leaveTop"), object: nil)
    }
    
    func acceptMsg(notification:Notification){
        var userInfo = notification.userInfo!
        let canScroll: String = userInfo["canScroll"] as! String
        if canScroll.isEqual("1") {
            self.canScroll = true
        }
    }
    
    func configSubViews() {
        
        var mainTableView = UITableView()
        //    数据源
        //var mainTableArr = NSMutableArray()
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.contentInset = UIEdgeInsetsMake(headerH, 0, 0, 0)
//        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
//        mainTableView.rowHeight = UITableViewAutomaticDimension;
//
     //   mainTableView.register(UINib(nibName: "SquareTableViewCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        self.view.addSubview(mainTableView)
        mainTableView.addSubview(HeadView)
    }
    
    fileprivate func setConstraint(){
        
//        HeadView.snp.makeConstraints { (make) in
//            make.top.left.right.equalTo(self.view)
//            make.height.equalTo(headerH)
//        }
        
//        VCManager.snp.makeConstraints { (make) in
//            make.top.equalTo(HeadView.snp.bottom)
//            make.left.right.equalTo(view)
//            make.height.equalTo(44)
//        }
//
//        pageMagager.view.snp.makeConstraints { (make) in
//            make.top.equalTo(VCManager.snp.bottom)
//            make.left.right.equalTo(view)
//            make.bottom.equalTo(view.snp.bottom).offset(-49)
//        }
    }
    
}

extension SquareViewController : UITableViewDelegate,UITableViewDataSource{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        let yOffset: CGFloat = scrollView.contentOffset.y
        let tabOffsetY: CGFloat = tableView.rect(forSection: 0).origin.y
        let offsetY: CGFloat = scrollView.contentOffset.y
        isTopIsCanNotMoveTabViewPre = isTopIsCanNotMoveTabView
        if offsetY >= tabOffsetY {
            scrollView.contentOffset = CGPoint(x: 0, y: tabOffsetY)
            isTopIsCanNotMoveTabView = true
        } else {
            isTopIsCanNotMoveTabView = false
            
        }
        if isTopIsCanNotMoveTabView != isTopIsCanNotMoveTabViewPre {
            if !isTopIsCanNotMoveTabViewPre! && isTopIsCanNotMoveTabView! {
                //NSLog(@"滑动到顶端");
                NotificationCenter.default.post(name: Notification.Name(rawValue:"goTop"), object: nil, userInfo:["canScroll":"1"] )
                self.canScroll = false
            }
            if isTopIsCanNotMoveTabViewPre! && !isTopIsCanNotMoveTabView! {
                //NSLog(@"离开顶端");
                if !self.canScroll! {
                    scrollView.contentOffset = CGPoint(x:0,y:tabOffsetY)
                }
            }
        }
        
        /**
         * 处理头部视图
         */
        if yOffset < -headerH {
            var f: CGRect = HeadView.frame
            f.origin.y = yOffset
            f.size.height = -yOffset
            f.origin.y = yOffset
            //改变头部视图的fram
            HeadView.frame = f
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenH - 64
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        cell.contentView.addSubview(VCManager)
        cell.contentView.addSubview(pageMagager.view)
        return cell
    }
}

//extension SquareViewController : TQScrollViewDelegate{
//
//    func tqScrollViewDidScroll(controller: SquareItemViewController, scrollY: CGFloat) {
//        print(scrollY)
//        var headerViewY: CGFloat = 0
//        if scrollY > 0 {
//            headerViewY = -scrollY
//            if scrollY > headerH {
//                headerViewY = CGFloat(-headerH)
//            }
//        } else {
//            headerViewY = 0
////            if scrollY > headerH {
////                headerViewY = CGFloat(headerH)
////            }
//        }
//
//        HeadView.snp.updateConstraints { (make) in
//            make.top.equalTo(view).offset(headerViewY)
//        }
//    }
//
//}
extension SquareViewController:VCManagerDelegate,PageManagerVC_Delegate{
    
    func VCManagerDidSelected(_ VCManager: VCManagerView, index: NSInteger, title: String) {
        
        pageMagager.setCurrentVCWithIndex(index)
    }
    func PageManagerDidFinishSelectedVC(indexOfVC: NSInteger) {
        VCManager.reloadSelectedBT(at: indexOfVC)
    }
    
}
