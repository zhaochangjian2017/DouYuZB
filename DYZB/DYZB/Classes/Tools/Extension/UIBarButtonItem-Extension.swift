//
//  UIBarButtonItem-Extension.swift
//  DYZB
//  对系统类做自定义的扩展
//  Created by CHANGJIAN ZHAO on 2018/9/13.
//  Copyright © 2018年 hingin. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //扩展类方法（swift开发中通常使用扩展构造函数的方式代替该类方法的实现方式）
    /*class func createItem(imageName : String, highImageName : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .normal)
        btn.frame = CGRect(origin: CGPoint(x: 0,y :0), size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    */
    
    //构造函数（注意：只能使用便利构造函数：1>要以convenience开头 2>在构造函数中必须明确调用一个设计的构造函数（即使用self调用自定义的item））
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize(width: 0, height: 0)) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .normal)
        }
        if size == CGSize(width: 0, height: 0) {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint(x: 0,y :0), size: size)
        }
        //创建UIBarButton
        self.init(customView : btn) //调用自定义的item
    }
}
