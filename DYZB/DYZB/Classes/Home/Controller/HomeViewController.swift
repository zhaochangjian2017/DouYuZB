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
        //1 设置UIBar左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", highImageName: "", size: CGSize(width: 0, height: 0))
        
        //2 设置UIBar右侧的按钮组
        let v_size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: v_size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: v_size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: v_size)
        /*
        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: v_size)
        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: v_size)
        let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: v_size)
        */
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
}
