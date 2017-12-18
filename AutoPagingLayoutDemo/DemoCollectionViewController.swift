//
//  DemoCollectionViewController.swift
//  AutoPagingLayoutDemo
//
//  Created by hooge on 16/5/20.
//  Copyright © 2016年 hooge. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DemoCollectionViewController: UIViewController {
    fileprivate var matrix:(rowCount:Int, columnCount:Int) = (0, 0)
    fileprivate let colors = [UIColor.red, UIColor.magenta, UIColor.green, UIColor.black, UIColor.purple,UIColor.cyan, UIColor.brown, UIColor.darkGray, UIColor.yellow, UIColor.orange, UIColor.gray, UIColor.blue, UIColor.lightGray, UIColor.magenta, UIColor(red:0.45, green: 0.33, blue: 0.30, alpha: 0.78), UIColor(red:0.48, green: 0.941, blue: 0.351, alpha: 0.66)]
    init(matrix:(rowCount:Int, columnCount:Int)){
        super.init(nibName: nil, bundle: nil)
        self.matrix = matrix
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.automaticallyAdjustsScrollViewInsets = false
        let configurator = WKAutomaticPagingFlowLayoutConfigurator()
        configurator.columnCountOfRow = self.matrix.columnCount
        configurator.rowCountOfPage = self.matrix.rowCount
        configurator.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        configurator.columnSpacing = 5
        configurator.lineSpacing = 5
        let layout = WKAutomaticPagingFlowLayout(layoutConfigurator: configurator)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        collectionView.isPagingEnabled = true
        var width:CGFloat = 0
        var height:CGFloat = 0
        width =  CGFloat(self.matrix.columnCount) * 100
        height = CGFloat(self.matrix.rowCount) * 100
        collectionView.wk_Size = CGSize(width: width, height: height)
        collectionView.center = self.view.center
        collectionView.backgroundColor = UIColor(red: 0.675, green: 0.176, blue: 0.452, alpha: 0.83)
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)
    }

 
}

extension DemoCollectionViewController:UICollectionViewDataSource{
    

    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 300
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        var  itemIndex:Int = indexPath.row
        
        if indexPath.row > self.colors.count - 1 {
            itemIndex = itemIndex % 10
        }
        cell.backgroundColor = self.colors[itemIndex]
        
        
        return cell
    }
}
