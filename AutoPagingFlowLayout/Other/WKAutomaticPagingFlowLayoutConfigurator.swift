//
//  WKAutomaticPagingFlowLayoutConfigurator.swift
//  WKChatViewControllerDemo
//
//  Created by hooge on 16/4/6.
//  Copyright © 2016年 hoowang. All rights reserved.
//

import UIKit

public struct WKAutomaticPagingFlowLayoutConfigurator {
    public var lineSpacing:CGFloat = 0.0   // 行间距
    public var columnSpacing:CGFloat = 0.0 // 列间距
    public var rowCountOfPage:Int = 0      // 一页有多少行
    public var columnCountOfRow:Int = 0    // 一行有多少列
    public var cellSize = CGSizeZero
    public var contentInsets:UIEdgeInsets = UIEdgeInsetsZero //contentView 外边距
    public var scrollDirection = UICollectionViewScrollDirection.Horizontal
}
