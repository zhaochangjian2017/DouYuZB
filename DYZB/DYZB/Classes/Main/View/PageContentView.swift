//
//  PageContentView.swift
//  DYZB
//
//  Created by CHANGJIAN ZHAO on 2018/9/14.
//  Copyright © 2018年 hingin. All rights reserved.
//

import UIKit

//
private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    //MARK:- 定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController? //PageContentView是被HomeViewController引用的，而这里的PageContentView又引用了Home的UIViewController，造成循环引用，所以定义该变量要使用弱引用关键字weak .. ?, 后面在使用该变量的时候也要加？
    
    //MARK:- 懒加载属性
    private lazy var collectionView: UICollectionView = {[weak self] in //注意：这里通过[weak self] in的方式来解决self.bounds.size循环引用的问题
       //1 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!//强制解包
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0)), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        //注意：如果要让collectionView显示在界面上，必须设置数据源, 进而要准时它的协议， 实现它的两个方法
        collectionView.dataSource = self
        //先注册创建cell的方法dequeueReusableCell()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI界面
extension PageContentView {
    private func setupUI() {
        //1 将所有的子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //2 添加UICollectionView，用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

// MARK:- 遵守UICollectionViewDataSource协议
extension PageContentView : UICollectionViewDataSource {
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1 创建Cell(从缓冲池里获取cell，注意：如果通过dequeueReusableCell方法获取cell，需要先注册)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //2 给cell设置内容
        //在设置值之前一定要先清理
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
}


// MARK:- 对外暴露的方法
extension PageContentView{
    
    //设置当前要滚动的位置
    func setCurrentIndex(currentIndex :  Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
}
