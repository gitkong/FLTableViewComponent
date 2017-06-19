//
//  DemoCollectionComponentTwo.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/18.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoCollectionComponentTwo: FLCollectionBaseComponent {
    
    override func register() {
        super.register()
    }
    
    override func numberOfItems() -> NSInteger {
        return 12
    }
    
    override func cellForItem(at item: Int) -> UICollectionViewCell {
        let cell : FLCollectionViewCell = super.cellForItem(at: item) as! FLCollectionViewCell
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    override func additionalOperationForReuseCell(_ cell: FLCollectionViewCell?) {
        let switchView : UISwitch = UISwitch.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 30))
        
        cell?.addSubview(switchView)
    }
    
    private func stringFromSize(at item: Int) -> String{
        
        return "\(customSize(at: item))"
    }
    
    private func customSize(at item: Int) -> CGSize {
        var width : CGFloat = 100, height : CGFloat = 100
        
        switch item {
        case 0:
            width = 60
            height = 30
        case 1:
            width = 90
            height = 40
        case 2:
            width = 100
            height = 60
        case 3:
            width = 122
            height = 100
        case 4:
            width = 30
            height = 40
        case 5:
            width = 120
            height = 60
        case 6:
            width = 60
            height = 120
        default:
            width = 30
            height = 50
        }
        return CGSize.init(width: width, height: height)
    }
    
    override func headerView() -> FLCollectionHeaderFooterView {
        let headerView : FLCollectionHeaderFooterView = super.headerView()
        headerView.backgroundColor = UIColor.blue
        return headerView
    }
    
    override func heightForHeader() -> CGFloat {
        return 50
    }
    
    
    override func footerView() -> FLCollectionHeaderFooterView {
        let footerView : FLCollectionHeaderFooterView = super.footerView()
        footerView.backgroundColor = UIColor.brown
        return footerView
    }
    
    override func additionalOperationForReuseFooterView(_ footerView: FLCollectionHeaderFooterView?) {
        let label : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 5, width: (footerView?.frame.size.width)!, height: 20))
        label.text = "hello gitKong"
        footerView?.addSubview(label)
    }
    
    override func heightForFooter() -> CGFloat {
        return 30
    }
    
//    override func sizeForItem(at item: Int) -> CGSize {
//        
//        return customSize(at: item)
//    }
    
    override func sectionInset() -> UIEdgeInsets {
        return UIEdgeInsetsMake(30, 30, 30, 30)
    }
    
}
