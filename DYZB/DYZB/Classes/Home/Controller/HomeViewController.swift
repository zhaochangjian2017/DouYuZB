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
    private lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        //titleView.backgroundColor = UIColor.purple
        //指定代理（遵守PageTitleViewDelegate协议，后面还要实现对应的方法）
        titleView.delegate = self //(步骤4)
        
        return titleView
    }()
    
    // MARK:- 懒加载pageContentView
    private lazy var pageContentView: PageContentView = {[weak self] in
        //1 确定内容的frmae
       let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
       let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
       
        //2 确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        //
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        //--代理使用步骤4：让HomePageViewController成为PageContentView的代理 (注意：成为代理就得遵守相应的协议)
        contentView.delegate = self
        
        return contentView
    }()
    
    // MARK:- 该方法是系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //1 设置UI
        setupUI()
        
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
        
        //3 添加contentView
        view.addSubview(pageContentView)
        
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

//MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {//(步骤5)
    func pageTitleView(titleViewL: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}


//--代理使用步骤5：遵守PageContentViewDelegate协议，实现它的方法
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
