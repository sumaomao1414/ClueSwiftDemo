//
//  SquareParentVC.swift
//  ClueSwiftDemo
//
//  Created by maomao on 2017/11/22.
//  Copyright © 2017年 maomao. All rights reserved.
//

import Foundation
import UIKit

class SquareParentVC: BaseViewController ,UIScrollViewDelegate,UIGestureRecognizerDelegate{
    
    var baseScrollView = UIScrollView()
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
   fileprivate var canScroll:Bool! = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(acceptMsg(notification:)), name: NSNotification.Name(rawValue: "goTop"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(acceptMsg(notification:)), name: NSNotification.Name(rawValue: "leaveTop"), object: nil)
    }
    
    func acceptMsg(notification:Notification){
        
        let notificationName: String = notification.name.rawValue
        if notificationName.isEqual("goTop") {
            var userInfo = notification.userInfo!
            let canScroll: String = userInfo["canScroll"] as! String
            if canScroll.isEqual("1") {
                self.canScroll = true
                baseScrollView.showsVerticalScrollIndicator = true
            }
        } else if notificationName.isEqual("leaveTop") {
            baseScrollView.contentOffset = CGPoint.init(x: 0, y: 0)
            self.canScroll = false
            baseScrollView.showsVerticalScrollIndicator = false
        }

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.canScroll {
            scrollView.contentOffset = CGPoint.zero
        }
        let offsetY: CGFloat = scrollView.contentOffset.y
        if offsetY <= 0 {
            NotificationCenter.default.post(name: Notification.Name(rawValue:"leaveTop"), object: nil, userInfo:["canScroll":"1"] )
        }
        baseScrollView = scrollView
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        if (otherGestureRecognizer.view?.isEqual(NSClassFromString("UILayoutContainerView")))! {
            // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
            if otherGestureRecognizer.state == .began && baseScrollView.contentOffset.x == 0 {
                return true
            }
        }
        return false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
