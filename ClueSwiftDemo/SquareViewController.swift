//
//  SquareViewController.swift
//  ClueSwiftDemo
//
//  Created by maomao on 2017/10/26.
//  Copyright © 2017年 maomao. All rights reserved.
//

import Foundation
import UIKit

class SquareViewController: BaseViewController {
    
    lazy var subViewTitles:[String] = {
        
        let array = ["五水共治","平安宣传","五水共治","平安宣传","五水共治","平安宣传","五水共治","平安宣传","五水共治","平安宣传"]
        return array
    }()
    
    
    lazy var VCManager:VCManagerView = {
        
        let manager = VCManagerView(frame:CGRect.init(x: 0, y: 0, width: kScreenW, height: 44))
        manager.delegate = self
        self.view.addSubview(manager)
        return manager
    }()
    
    lazy var pageMagager:PageManagerVC = {
        
        let manager = PageManagerVC.init(superController: self, childControllerS: [SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),SquareItemViewController(),])
        manager.delegate = self
        self.view.addSubview(manager.view)
        return manager
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        VCManager.title_font = UIFont.systemFont(ofSize: 15)
        VCManager.sliderWidthType = .ButtonWidth
        VCManager.title_array = subViewTitles
        setConstraint()
    }
    
    fileprivate func setConstraint(){
        
        pageMagager.view.snp.makeConstraints { (make) in
            make.top.equalTo(VCManager.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-49)
        }
    }
}

extension SquareViewController:VCManagerDelegate,PageManagerVC_Delegate{
    
    func VCManagerDidSelected(_ VCManager: VCManagerView, index: NSInteger, title: String) {
        
        pageMagager.setCurrentVCWithIndex(index)
    }
    func PageManagerDidFinishSelectedVC(indexOfVC: NSInteger) {
        VCManager.reloadSelectedBT(at: indexOfVC)
    }
    
}
