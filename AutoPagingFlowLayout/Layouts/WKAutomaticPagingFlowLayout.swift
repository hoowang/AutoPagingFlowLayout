//
//  WKAutomaticPagingFlowLayout.swift
//  WKChatViewControllerDemo
//
//  Created by hooge on 16/4/6.
//  Copyright © 2016年 hoowang. All rights reserved.
//

import UIKit

public class WKAutomaticPagingFlowLayout: UICollectionViewFlowLayout {
    // MARK: - 初始化部分
    private var flowLayoutCfg = WKAutomaticPagingFlowLayoutConfigurator()
    private var pageContentInsets:UIEdgeInsets {
        get{
            return self.flowLayoutCfg.contentInsets
        }
    }

   public init(layoutConfigurator:WKAutomaticPagingFlowLayoutConfigurator) {
        super.init()
        self.scrollDirection = layoutConfigurator.scrollDirection
        self.flowLayoutCfg = layoutConfigurator
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("Does not support xib loading mode !!!")
    }
}

// MARK:- 私有方法
extension WKAutomaticPagingFlowLayout{
    private func numberOfItems() ->(Int){
        let section = 0
        let numberOfItems = collectionView?.dataSource?.collectionView(collectionView!, numberOfItemsInSection: section)
        return numberOfItems!
    }

    private func pageSize() -> (CGSize){
        return (collectionView?.bounds.size)!
    }

    private func avaliableSizePerPage() -> (CGSize){

        return CGSizeMake(pageSize().width - pageContentInsets.left -
            pageContentInsets.right,
                          pageSize().height - pageContentInsets.top -
                            pageContentInsets.bottom)
    }

    //一行有多少列
    private func numberOfItemsPerRow() -> (Int){
        return self.flowLayoutCfg.columnCountOfRow
    }

    // 一页有多少行
    private func numberOfRowsPerPage() -> (Int){
        return self.flowLayoutCfg.rowCountOfPage
    }

    // 一页的总数
    private func numberOfItemsPerPage() -> (Int){
        return numberOfItemsPerRow() * numberOfRowsPerPage()
    }

    // item frame 计算
    private func calcItemFrameWithIndexPath(indexPath:NSIndexPath) ->(CGRect){
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
            let frame = CGRectMake(x, y, width, height)

            return frame
        }

        x = page * self.pageSize().width + self.pageContentInsets.left +
            CGFloat(n) * (self.flowLayoutCfg.cellSize.width + self.flowLayoutCfg.columnSpacing)

        y = self.pageContentInsets.top +
            row * (self.flowLayoutCfg.cellSize.height + self.flowLayoutCfg.lineSpacing)

        width = self.flowLayoutCfg.cellSize.width
        height = self.flowLayoutCfg.cellSize.height
        
        return CGRectMake(x, y, width, height)
    }
}

// MARK: - 重写父类方法
extension WKAutomaticPagingFlowLayout{
    override public func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath:indexPath)
        attributes.frame = calcItemFrameWithIndexPath(indexPath)

        return attributes
    }

    override public func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var attributeArray = [UICollectionViewLayoutAttributes]()
        for i in 0...self.numberOfItems() - 1 {
            let attributes =
                layoutAttributesForItemAtIndexPath(NSIndexPath(forRow: i, inSection: 0))
            if CGRectIntersectsRect(rect, (attributes?.frame)!) {
                attributeArray.append(attributes!)
            }
        }

        return attributeArray
    }

    override public func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        if (CGSizeEqualToSize(collectionView!.bounds.size, newBounds.size)) {
            return false
        }else{
            return true
        }
    }

    public override func collectionViewContentSize() -> (CGSize){
        let items:CGFloat = CGFloat(numberOfItems())
        let perPageItems:CGFloat = CGFloat(numberOfItemsPerPage())
        let width = ceil(items / perPageItems) * pageSize().width
        let height = pageSize().height
        return CGSizeMake(width, height)
    }
}
