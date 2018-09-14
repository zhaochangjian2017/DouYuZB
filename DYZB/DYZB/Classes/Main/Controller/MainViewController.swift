//
//  MainViewController.swift
//  DYZB
//
//  Created by CHANGJIAN ZHAO on 2018/9/13.
//  Copyright © 2018年 hingin. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc(storyboardName: "Home")
        addChildVc(storyboardName: "Live")
        addChildVc(storyboardName: "Follow")
        addChildVc(storyboardName: "Profile")
        
    }
    
    
    /*
     *
     */
    private func addChildVc(storyboardName : String) {
        
        //1 通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        
        //2 将childVc作为子控制器
        addChildViewController(childVc)
        
    }

}
