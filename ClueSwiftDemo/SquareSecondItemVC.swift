//
//  SquareSecondItemVC.swift
//  ClueSwiftDemo
//
//  Created by maomao on 2017/11/9.
//  Copyright © 2017年 maomao. All rights reserved.
//

import Foundation

class SquareSecondItemVC: BaseViewController {
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! PhotoViewController
        let identifier: NSString = NSString(string: segue.identifier!)
        controller.index = Int(identifier.intValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
