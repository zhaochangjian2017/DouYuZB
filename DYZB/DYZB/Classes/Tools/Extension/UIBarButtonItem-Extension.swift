//
//  UIBarButtonItem-Extension.swift
//  DYZB
//  对系统类做自定义的扩展
//  Created by CHANGJIAN ZHAO on 2018/9/13.
//  Copyright © 2018年 hingin. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //扩展类方法
    class func createItem(imageName : String, highImageName : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .normal)
        btn.frame = CGRect(origin: CGPoint(x: 0,y :0), size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
}
