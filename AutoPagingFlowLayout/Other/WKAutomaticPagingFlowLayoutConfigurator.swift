//
//  WKAutomaticPagingFlowLayoutConfigurator.swift
//  WKChatViewControllerDemo
//
//  Created by hooge on 16/4/6.
//  Copyright © 2016年 hoowang. All rights reserved.
//

import UIKit

open class WKAutomaticPagingFlowLayoutConfigurator : NSObject{
    open var lineSpacing:CGFloat = 0.0   // 行间距
    open var columnSpacing:CGFloat = 0.0 // 列间距
    open var rowCountOfPage:Int = 0      // 一页有多少行
    open var columnCountOfRow:Int = 0    // 一行有多少列
    open var cellSize = CGSize.zero
    open var contentInsets:UIEdgeInsets = UIEdgeInsets.zero //contentView 外边距
}
