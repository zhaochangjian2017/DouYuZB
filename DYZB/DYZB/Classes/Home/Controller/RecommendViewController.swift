//
//  RecommendViewController.swift
//  DYZB
//
//  Created by CHANGJIAN ZHAO on 2018/9/15.
//  Copyright © 2018年 hingin. All rights reserved.
//

import UIKit

//定义常量
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kItemH = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {

    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {[unowned self] in
       //1 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //设置组头(然后再在组头放一个view)第一步：设置大小
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        //设置section内边距(解决selection边距都集中在中间显示的问题)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        
        
       //2 创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout : layout)
        collectionView.backgroundColor = UIColor.red
        //设置属性：让collectionView的布局大小随着负控件的大小动态调整
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        
        //
        collectionView.dataSource = self
        
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        //在每个组头中放置一个view（这里要先注册，在实现类方法）
        //第二步：注册
        //UICollectionElementKindSectionHeader-view要显示在组中的位置，这里表示显示在组的顶部
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()

    }


}


// MARK:- 设置UI界面内容
extension RecommendViewController {
    
    private func setupUI() {
        //1. 将UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
        
    }
    
}

// MARK:- 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource{
    //一共有多少组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    //每一组一共有多少条数据
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {//特殊情况：第一组有8条记录
            return 8
        }
        
        return 4 //其余的情况都是只有4条记录
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1 后去cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        cell.backgroundColor = UIColor.orange
        
        return cell
    }
    
    //第三步：实现方法
    //为组头创建view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1 取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)

        headerView.backgroundColor = UIColor.gray
        
        return headerView
    }
}
