//
//  PageTitleView.swift
//  DYZB
//
//  Created by CHANGJIAN ZHAO on 2018/9/14.
//  Copyright © 2018年 hingin. All rights reserved.
//

import UIKit

//
private let kScrollLineH : CGFloat = 2

//设置代理，实现title和滚动视图的联系
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleViewL: PageTitleView, selectedIndex index: Int)
}


//
class PageTitleView: UIView {

    //MARK:- 定义属性
    private var currentIndex : Int = 0
    private var titles : [String]
    //定义代理属性
    weak var delegate: PageTitleViewDelegate? //指定该属性必须遵守该代理的协议 并且是弱引用的变量
    
    //MARK:- 懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()//用于存储label
    
    private lazy var scrollView : UIScrollView = {
       let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = false //水平线不需要显示
        scrollview.scrollsToTop = false //要实现状态栏点击回到顶端的效果，需要将其他srolls设置为不需要显示
        scrollview.bounces = false //设置菜单左右滚动不能超过view的范围
        scrollview.isPagingEnabled = false //分页效果不需要(该属性默认就是false，这里可以不设置)
        
        return scrollview
    }()
    
    //MARK:- 懒加载滚动线
    private lazy var scrollLine : UIView = {
       let srcollline = UIView()
       srcollline.backgroundColor = UIColor.orange
        
       return srcollline
    }()
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


//MARK:- 设置UI界面
extension PageTitleView {
    private func setupUI() {
        //1 添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2 添加title对应的label
        setupTitleLabels()
        
        //3 设置底线和滚动滑块
        setupBottomLineAndScrollLine()
    }
    
    //
    private func setupTitleLabels() {
        
        //0 确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for(index, title) in titles.enumerated() {
            //1. 创建UILabel
            let label = UILabel()
            
            //2 设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //3 设置label的frame(有了frame后才能显示在界面)
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
         
            //4 将label添加到scrollView中
            scrollView.addSubview(label)
            //将新创建的label缓存到label数组中
            titleLabels.append(label)
            
            //5 给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
    
    //
    private func setupBottomLineAndScrollLine() {
        //1 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        //scrollView.addSubview(bottomLine)
        addSubview(bottomLine)
        
        //2 添加scrollLine
        scrollView.addSubview(scrollLine)
        //2.1 获取第一个label
        guard let firstLabel = titleLabels.first else { return } //由于titleLabels.first是可选类型，所以这里通过guard判断下，如果没有值就直接return
        firstLabel.textColor = UIColor.orange        
        //2.2 设置scrollline的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
}

//MARK:- 监听label的点击事件
extension PageTitleView {
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
        //1 获取当前label
        guard let currentLabel = tapGes.view as? UILabel else { return } //as? UILabel的作用是将uiview转成uilabel
        
        //2 获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3 切换文字的颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        //4 保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        //5 滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
                self.scrollLine.frame.origin.x = scrollLineX
            }
        
        //6 通知代理做事情
        delegate?.pageTitleView(titleViewL: self, selectedIndex: currentIndex)
        
        
    }
}
