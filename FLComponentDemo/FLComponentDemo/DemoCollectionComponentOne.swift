//
//  DemoCollectionComponentOne.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoCollectionComponentOne: FLCollectionBaseComponent {
    
    override func numberOfItems() -> NSInteger {
        return 3
    }
    
    override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.cellForItem(at: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    override func headerView(at section: Int) -> UICollectionReusableView {
        let headerView : UICollectionReusableView = super.headerView(at: section)
        headerView.backgroundColor = UIColor.gray
        return headerView
    }
    
    override func heightForHeader(at section : Int) -> CGFloat {
        return 100
    }
    
}
