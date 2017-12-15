//
//  WKAutomaticPagingFlowLayout.swift
//  WKChatViewControllerDemo
//
//  Created by hooge on 16/4/6.
//  Copyright © 2016年 hoowang. All rights reserved.
//

import UIKit

open class WKAutomaticPagingFlowLayout: UICollectionViewFlowLayout {
    // MARK: - 初始化部分
    fileprivate var flowLayoutCfg = WKAutomaticPagingFlowLayoutConfigurator()
    fileprivate var pageContentInsets:UIEdgeInsets {
        get{
            return self.flowLayoutCfg.contentInsets
        }
    }

   public init(layoutConfigurator:WKAutomaticPagingFlowLayoutConfigurator) {
        super.init()
        //self.scrollDirection = layoutConfigurator.scrollDirection
        self.flowLayoutCfg = layoutConfigurator
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("Does not support xib loading mode !!!")
    }
}

// MARK:- 私有方法
extension WKAutomaticPagingFlowLayout{
    fileprivate func numberOfItems() ->(Int){
        let section = 0
        let numberOfItems = collectionView?.dataSource?.collectionView(collectionView!, numberOfItemsInSection: section)
        return numberOfItems!
    }

    fileprivate func pageSize() -> (CGSize){
        return (collectionView?.bounds.size)!
    }

    fileprivate func avaliableSizePerPage() -> (CGSize){

        var width:CGFloat = 0.0
        var height:CGFloat = 0.0

        width = pageSize().width - pageContentInsets.left -
            pageContentInsets.right
        height = pageSize().height - pageContentInsets.top -
            pageContentInsets.bottom

 
        return CGSize(width: width, height: height)
    }

    //一行有多少列
    fileprivate func numberOfItemsPerRow() -> (Int){
        return self.flowLayoutCfg.columnCountOfRow
    }

    // 一页有多少行
    fileprivate func numberOfRowsPerPage() -> (Int){
        return self.flowLayoutCfg.rowCountOfPage
    }

    // 一页的总数
    fileprivate func numberOfItemsPerPage() -> (Int){
        return numberOfItemsPerRow() * numberOfRowsPerPage()
    }

    // item frame 计算
    fileprivate func calcItemFrameWithIndexPath(_ indexPath:IndexPath) ->(CGRect){
        let index = indexPath.row
        let page = floor( CGFloat(index) / CGFloat(self.numberOfItemsPerPage()))
        let row  = floor( CGFloat(index % self.numberOfItemsPerPage()) / CGFloat(self.numberOfItemsPerRow()))

        let n    = index % self.numberOfItemsPerRow()
        var x:CGFloat = 0.0;
        var y:CGFloat = 0.0;
        var width:CGFloat = 0.0;
        var height:CGFloat = 0.0;

        if (0 == self.flowLayoutCfg.cellSize.width) {
            width =
                (self.collectionView!.wk_Width - 2 * self.pageContentInsets.left -
                    CGFloat(self.numberOfItemsPerRow() - 1) * flowLayoutCfg.columnSpacing) /
                CGFloat(self.numberOfItemsPerRow())

            height = (self.flowLayoutCfg.cellSize.height != 0) ?  (self.flowLayoutCfg.cellSize.height):
                ((self.collectionView!.wk_Height - 2 * self.pageContentInsets.bottom -
                    CGFloat(self.flowLayoutCfg.rowCountOfPage - 1) * self.flowLayoutCfg.lineSpacing) /
                    CGFloat(self.flowLayoutCfg.rowCountOfPage))

            x = page * self.pageSize().width + self.pageContentInsets.left
                + CGFloat(n) * (width + self.flowLayoutCfg.columnSpacing)

            y = self.pageContentInsets.top +
                row * (height + self.flowLayoutCfg.lineSpacing)
            let frame = CGRect(x: x, y: y, width: width, height: height)

            return frame
        }

        x = page * self.pageSize().width + self.pageContentInsets.left +
            CGFloat(n) * (self.flowLayoutCfg.cellSize.width + self.flowLayoutCfg.columnSpacing)

        y = self.pageContentInsets.top +
            row * (self.flowLayoutCfg.cellSize.height + self.flowLayoutCfg.lineSpacing)

        width = self.flowLayoutCfg.cellSize.width
        height = self.flowLayoutCfg.cellSize.height
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

// MARK: - 重写父类方法
extension WKAutomaticPagingFlowLayout{
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith:indexPath)
        attributes.frame = calcItemFrameWithIndexPath(indexPath)

        return attributes
    }

    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard self.numberOfItems() > 0 else {
            
            return super.layoutAttributesForElements(in: rect)
        }
        var attributeArray = [UICollectionViewLayoutAttributes]()
        for i in 0...self.numberOfItems() - 1 {
            let attributes =
                layoutAttributesForItem(at: IndexPath(row: i, section: 0))
            if rect.intersects((attributes?.frame)!) {
                attributeArray.append(attributes!)
            }
        }

        return attributeArray
    }

    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if (collectionView!.bounds.size.equalTo(newBounds.size)) {
            return false
        }else{
            return true
        }
    }

    open override var collectionViewContentSize : (CGSize){
        //super.collectionViewContentSize()
        let items:CGFloat = CGFloat(numberOfItems())
        let perPageItems:CGFloat = CGFloat(numberOfItemsPerPage())
        var width:CGFloat = 0.0
        var height:CGFloat = 0.0
        width = ceil(items / perPageItems) * pageSize().width
        height = pageSize().height
        return CGSize(width: width, height: height)
    }
}
