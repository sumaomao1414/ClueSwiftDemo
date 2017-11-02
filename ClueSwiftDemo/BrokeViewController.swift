//
//  BrokeViewController.swift
//  ClueSwiftDemo
//
//  Created by maomao on 2017/10/26.
//  Copyright © 2017年 maomao. All rights reserved.
//

import Foundation
import UIKit

class BrokeViewController: BaseViewController {
    
    lazy var webView :UIWebView = {
        
        let WebView = UIWebView(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH-49))
        WebView.scrollView.bounces = false
        return WebView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "爆料"
        view.addSubview(webView)
        webView.delegate = self
        let request = URLRequest(url: URL(string:"https://www.panda.tv")!)
        webView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BrokeViewController : UIWebViewDelegate{
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.description.contains("https://m.panda.tv/room.html") {
            return false
        }else{
            return true
        }
    }
}





































