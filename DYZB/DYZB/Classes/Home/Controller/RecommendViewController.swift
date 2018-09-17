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
//private let kItemH = kItemW * 3 / 4
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {

    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {[unowned self] in
       //1 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemW)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //设置组头(然后再在组头放一个view)第一步：设置大小
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        //设置section内边距(解决selection边距都集中在中间显示的问题)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        
        
       //2 创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout : layout)
        collectionView.backgroundColor = UIColor.white
        //设置属性：让collectionView的布局大小随着负控件的大小动态调整
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        
        //设置数据源
        collectionView.dataSource = self
        //设置代理
        collectionView.delegate = self //由于要实现定制化的cell的大小，所以需要实现特殊的协议：UICollectionViewDelegateFlowLayout 该协议还是继承至传统的代理协议UICollectionViewDelegate
        
        
        //注册cell
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        //这里采用NIB自定义的cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        //这里采用NIB自定义的cell
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        //在每个组头中放置一个view（这里要先注册，在实现类方法）
        //第二步：注册
        //UICollectionElementKindSectionHeader-view要显示在组中的位置，这里表示显示在组的顶部
        //collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        //通过NIB来注册一个collectionView
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
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

// MARK:- 遵守UICollectionView的数据源协议， 遵守
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
    
    //获取cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1 定义cell
        let cell : UICollectionViewCell!  //collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        
        //2 按条件获取指定的cell
        if(indexPath.section == 1) {
            //获取颜值cell
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        } else {
            //获取普通cell
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        return cell
    }
    
    //第三步：实现方法
    //为组头创建view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1 取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        return headerView
    }
    
    //针对协议UICollectionViewDelegateFlowLayout，实现item尺寸的设置
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 1) {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
