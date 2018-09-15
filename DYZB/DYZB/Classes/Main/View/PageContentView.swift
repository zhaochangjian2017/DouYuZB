//
//  PageContentView.swift
//  DYZB
//
//  Created by CHANGJIAN ZHAO on 2018/9/14.
//  Copyright © 2018年 hingin. All rights reserved.
//

import UIKit

//定义代理协议（作用是在滚动视图的时候，让title和titleline联动）--代理使用步骤1:定义代理即方法
protocol PageContentViewDelegate : class {
    func pageContentView (contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}


//
private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    //MARK:- 定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController? //PageContentView是被HomeViewController引用的，而这里的PageContentView又引用了Home的UIViewController，造成循环引用，所以定义该变量要使用弱引用关键字weak .. ?, 后面在使用该变量的时候也要加？
    private var startOffsetX : CGFloat = 0//拖拽偏移量
    private var isForbidScrollDelegate : Bool = false //禁用scroll代理标识(解决问题：当点击Title的时候，会调用scroll，而scroll又会触发title的代理，从而导致循环调用的问题)
    weak var delegate : PageContentViewDelegate? //--代理使用步骤2：定义代理属性
    
    
    
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
        
        //设置代理，用于监听collectionView的滚动
        collectionView.delegate = self;
        
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


// MARK:- 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    //拖拽的偏移量
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //一旦检测到scroll开始拖动了，就将scroll代理标识设置为否(区分出是点击title触发的scroll拖动事件，还是手指操作的scroll拖动事件)
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    
    //监测滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断出是点击title触发的scroll拖动事件true，还是手指操作的scroll拖动事件false
        if isForbidScrollDelegate { return } //如果是点击title触发的scroll事件，程序终止并退出
        
        //1 定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2 判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if(currentOffsetX > startOffsetX) {//左滑
            //1) 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)//得到左滑比例
            //2)计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //3）计算targetIndex
            targetIndex = sourceIndex + 1
            if(targetIndex >= childVcs.count) {
                targetIndex = childVcs.count - 1
            }
            //4 如果源scrollView完全滑过去了
            if(currentOffsetX - startOffsetX == scrollViewW) {
                progress = 1
                targetIndex = sourceIndex
            }
        } else {//右滑
            //1) 计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)) //得到右滑比例
            //2)计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //3）计算sourceIndex
            sourceIndex = targetIndex + 1
            if(sourceIndex >= childVcs.count) {
                sourceIndex = childVcs.count - 1
            }
        }
        
        //--代理使用步骤3：通知代理  （下一步就是让首页HomeViewController成为代理）
        //3 获取需要的数据(滚动的进度progress、sourceIndex对应的label、targetIndex对应的label、判断左滑还是右滑-根据偏移量对比实现),将这三个值传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        //print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
    }
}

// MARK:- 对外暴露的方法
extension PageContentView{
    
    //设置当前要滚动的位置
    func setCurrentIndex(currentIndex :  Int) {
        //1 记录需要执行代理的方法
        isForbidScrollDelegate = true
        
        //2 滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
}


// MARK:-  //--代理使用步骤3
