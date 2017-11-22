//
//  ExampleProvider.swift
//  ESTabBarControllerExample
//
//  Created by lihao on 2017/2/9.
//  Copyright © 2017年 Vincent Li. All rights reserved.
//

import UIKit
import ESTabBarController_swift

enum ExampleProvider {
    
       static func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> UINavigationController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        tabBarController.tabBar.backgroundImage = UIImage(named: "background_dark")
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
				let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
				let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
				alertController.addAction(takePhotoAction)
				let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
				alertController.addAction(selectFromAlbumAction)
				let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
				alertController.addAction(cancelAction)
				tabBarController?.present(alertController, animated: true, completion: nil)
			}
        }

        let v1 = HomeViewController()
        let v2 = SquareViewController()
        let v3 = BrokeViewController()
        let v4 = NoticeViewController()
        let v5 = UIStoryboard(name: "Mine", bundle: nil).instantiateInitialViewController() as! MineViewController
        
        v1.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_click"))
        v2.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Find", image: UIImage(named: "square"), selectedImage: UIImage(named: "square_click"))
        v3.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: UIImage(named: "publish"), selectedImage: UIImage(named: "publish"))
        v4.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Favor", image: UIImage(named: "announcement"), selectedImage: UIImage(named: "announcement_click"))
        v5.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Me", image: UIImage(named: "my"), selectedImage: UIImage(named: "my_click"))
        
        tabBarController.viewControllers = [v1, v2, v3, v4, v5]
        
        let navigationController = UINavigationController.init(rootViewController: tabBarController)
        tabBarController.title = "Example"
        return navigationController
    }
}
