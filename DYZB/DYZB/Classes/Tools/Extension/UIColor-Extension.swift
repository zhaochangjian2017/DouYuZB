//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by CHANGJIAN ZHAO on 2018/9/14.
//  Copyright © 2018年 hingin. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
