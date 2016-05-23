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
    private var matrix:(rowCount:Int, columnCount:Int) = (0, 0)
    private let colors = [UIColor.redColor(), UIColor.magentaColor(), UIColor.greenColor(), UIColor.blackColor(), UIColor.purpleColor(),UIColor.cyanColor(), UIColor.brownColor(), UIColor.darkGrayColor(), UIColor.yellowColor(), UIColor.orangeColor(), UIColor.grayColor(), UIColor.blueColor(), UIColor.lightGrayColor(), UIColor.magentaColor(), UIColor(red:0.45, green: 0.33, blue: 0.30, alpha: 0.78), UIColor(red:0.48, green: 0.941, blue: 0.351, alpha: 0.66)]
    init(matrix:(rowCount:Int, columnCount:Int)){
        super.init(nibName: nil, bundle: nil)
        self.matrix = matrix
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.automaticallyAdjustsScrollViewInsets = false
        var configurator = WKAutomaticPagingFlowLayoutConfigurator()
        configurator.columnCountOfRow = self.matrix.columnCount
        configurator.rowCountOfPage = self.matrix.rowCount
        configurator.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        configurator.scrollDirection = .Horizontal
        configurator.columnSpacing = 5
        configurator.lineSpacing = 5
        let layout = WKAutomaticPagingFlowLayout(layoutConfigurator: configurator)
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout:layout)
        collectionView.pagingEnabled = true
        collectionView.wk_Size = CGSizeMake(
            CGFloat(self.matrix.columnCount) * 100, CGFloat(self.matrix.rowCount) * 100)
        
        collectionView.center = self.view.center
        collectionView.backgroundColor = UIColor(red: 0.675, green: 0.176, blue: 0.452, alpha: 0.83)
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)
    }

 
}

extension DemoCollectionViewController:UICollectionViewDataSource{
    

    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 300
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        var  itemIndex:Int = indexPath.row
        
        if indexPath.row > self.colors.count - 1 {
            itemIndex = itemIndex % 10
        }
        cell.backgroundColor = self.colors[itemIndex]
        
        
        return cell
    }
}
