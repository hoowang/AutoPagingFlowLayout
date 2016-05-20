# AutoPagingFlowLayout
根据collectionView datasource自动分页的，展示item的布局实现。废话不多说，请直接看图~~
![image](https://github.com/hoowang/AutoPagingFlowLayout/blob/master/AutoPage.gif)  

## 使用方法：
###1.创建flowlayout configurator对象 并配置参数

```Swift
        let configurator = WKAutomaticPagingFlowLayoutConfigurator()
        configurator.columnCountOfRow = 3 // 每行有3列
        configurator.rowCountOfPage = 2   // 每页展示2行
        configurator.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10) //边距
        configurator.scrollDirection = .Horizontal
        configurator.columnSpacing = 5   // 行间距
        configurator.lineSpacing = 5 	 // 列间距
```
### 2.根据layout创建CollectionView 
```Swift
	    let layout = WKAutomaticPagingFlowLayout(layoutConfigurator: configurator)
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout:layout)
        collectionView.pagingEnabled = true //自行指定分页属性 根据需要
        collectionView.wk_Size = CGSizeMake(
            CGFloat(self.matrix.columnCount) * 100, CGFloat(self.matrix.rowCount) * 100)
```

### 3.其他的步骤与正常使用UICollectionView一致 

此布局会根据datasource 自动分页 并根据相关配置参数分配每个Item.

