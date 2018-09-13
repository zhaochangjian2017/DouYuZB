//
//  AppDelegate.swift
//  DYZB
//
//  Created by CHANGJIAN ZHAO on 2018/9/13.
//  Copyright © 2018年 hingin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //设置uitabbar中图标的颜色
        UITabBar.appearance().tintColor = UIColor.orange;
        
        return true
    }


}

