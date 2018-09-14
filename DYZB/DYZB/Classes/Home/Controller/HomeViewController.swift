//
//  HomeViewController.swift
//  DYZB
//
//  Created by CHANGJIAN ZHAO on 2018/9/13.
//  Copyright © 2018年 hingin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //
        setupUI()
        
    }

}


/*
 * MARK: -设置UI界面
 */
extension HomeViewController {
    
    private func setupUI() {
        //1 设置导航栏
        setupNavigationBar()
        
    }
    
    //设置导航栏
    private func setupNavigationBar() {
        //1 设置左侧的item
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)

        let v_size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: v_size)
        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: v_size)
        let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: v_size)
        
        
//        let size = CGSize(width: 40, height: 40)
//        //2 设置右侧的item
//        let historyBtn = UIButton()
//        historyBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
//        historyBtn.setImage(UIImage(named: "Image_my_history_click"), for: .highlighted)
//        historyBtn.sizeToFit()
//        //historyBtn.frame = CGRect(origin: , size: size)
//        let historyItem = UIBarButtonItem(customView: historyBtn)
//
//
//        let searchBtn = UIButton()
//        searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
//        searchBtn.setImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
//        searchBtn.sizeToFit()
//        //searchBtn.frame = CGRect(origin: CGPoint, size: size)
//        let searchItem = UIBarButtonItem(customView: searchBtn)
//
//
//        let qrcodeBtn = UIButton()
//        qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
//        qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
//        qrcodeBtn.sizeToFit()
//        //qrcodeBtn.frame = CGRect(origin: CGPoint, size: size)
//        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
//
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
}
