//
//  DemoCollectionComponentOne.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoCollectionComponentOne: FLCollectionBaseComponent {
    
    override func register() {
        super.register()
        self.collectionView?.register(UINib.init(nibName: "DemoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: self.cellIdentifier)
    }
    
    override func numberOfItems() -> NSInteger {
        return 12
    }
    
    override func cellForItem(at item: Int) -> UICollectionViewCell {
        let cell : DemoCollectionViewCell = super.cellForItem(at: item) as! DemoCollectionViewCell
        cell.backgroundColor = UIColor.red
        cell.textLabel.text = stringFromSize(at: item)
        return cell
    }
    
    private func stringFromSize(at item: Int) -> String{
        
        return "\(customSize(at: item))"
    }
    
    private func customSize(at item: Int) -> CGSize {
        var width : CGFloat = 100, height : CGFloat = 100
        switch item {
        case 0:
            width = 120
            height = 60
        case 1:
            width = 60
            height = 80
        case 2:
            width = 100
            height = 60
        case 3:
            width = 90
            height = 50
        case 4:
            width = 130
            height = 40
        case 5:
            width = 60
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
    
    override func headerView() -> UICollectionReusableView {
        let headerView : UICollectionReusableView = super.headerView()
        headerView.backgroundColor = UIColor.gray
        return headerView
    }
    
    override func heightForHeader() -> CGFloat {
        return 20
    }
    
    override func footerView() -> UICollectionReusableView {
        let footerView : UICollectionReusableView = super.footerView()
        footerView.backgroundColor = UIColor.purple
        return footerView
    }
    
    override func heightForFooter() -> CGFloat {
        return 60
    }
    
    override func sizeForItem(at item: Int) -> CGSize {
        
        return customSize(at: item)
    }
    
    override func sectionInset() -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    override func minimumLineSpacing() -> CGFloat {
        return 50
    }
    
    override func minimumInteritemSpacing() -> CGFloat {
        return 50
    }
    
}
