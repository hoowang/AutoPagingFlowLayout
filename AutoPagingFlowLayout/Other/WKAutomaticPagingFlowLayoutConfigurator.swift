//
//  WKAutomaticPagingFlowLayoutConfigurator.swift
//  WKChatViewControllerDemo
//
//  Created by hooge on 16/4/6.
//  Copyright © 2016年 hoowang. All rights reserved.
//

import UIKit

public class WKAutomaticPagingFlowLayoutConfigurator: NSObject {
    var lineSpacing:CGFloat = 0.0   // 行间距
    var columnSpacing:CGFloat = 0.0 // 列间距
    var rowCountOfPage:Int = 0      // 一页有多少行
    var columnCountOfRow:Int = 0    // 一行有多少列
    var cellSize = CGSizeZero
    var contentInsets:UIEdgeInsets = UIEdgeInsetsZero //contentView 外边距
    var scrollDirection = UICollectionViewScrollDirection.Horizontal
}
