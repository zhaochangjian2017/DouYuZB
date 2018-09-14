//
//  HomeViewController.swift
//  DYZB
//
//  Created by CHANGJIAN ZHAO on 2018/9/13.
//  Copyright © 2018年 hingin. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    // MARK:- 懒加载属性
    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        //titleView.backgroundColor = UIColor.purple
        return titleView
    }()
    
    
    // MARK:- 该方法是系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //1 设置导航栏
        setupUI()
        
        //2 添加TitleView
        view.addSubview(pageTitleView)
        
    }

}


/*
 * MARK: -设置UI界面
 */
extension HomeViewController {
    //
    private func setupUI() {
        //0 由于系统在加载view的时候，默认给scrollview设置了内边距，这会导致scrollview无法显示的问题，所以需要置否(不需要设置内边距)
        automaticallyAdjustsScrollViewInsets = false
        
        //1 设置导航栏
        setupNavigationBar()
    
        //2 添加titleview
        view.addSubview(pageTitleView)
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
