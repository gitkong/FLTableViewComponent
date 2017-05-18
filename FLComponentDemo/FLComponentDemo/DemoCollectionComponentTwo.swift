//
//  DemoCollectionComponentTwo.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/18.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoCollectionComponentTwo: FLCollectionBaseComponent {
    
    override func register() {
        super.register()
        self.collectionView?.register(UINib.init(nibName: "DemoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: self.cellIdentifier)
    }
    
    override func numberOfItems() -> NSInteger {
        return 12
    }
    
    override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell : DemoCollectionViewCell = super.cellForItem(at: indexPath) as! DemoCollectionViewCell
        cell.backgroundColor = UIColor.lightGray
        cell.textLabel.text = stringFromSize(at: indexPath)
        return cell
    }
    
    private func stringFromSize(at indexPath : IndexPath) -> String{
        
        return "\(customSize(at: indexPath))"
    }
    
    private func customSize(at indexPath : IndexPath) -> CGSize {
        var width : CGFloat = 100, height : CGFloat = 100
        
        switch indexPath.item {
        case 0:
            width = 60
            height = 30
        case 1:
            width = 90
            height = 100
        case 2:
            width = 100
            height = 60
        case 3:
            width = 120
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
    
    override func headerView(at section: Int) -> UICollectionReusableView {
        let headerView : UICollectionReusableView = super.headerView(at: section)
        headerView.backgroundColor = UIColor.blue
        return headerView
    }
    
    override func heightForHeader(at section : Int) -> CGFloat {
        return 30
    }
    
    override func sizeForItem(withLayout collectionViewLayout: UICollectionViewLayout, at indexPath: IndexPath) -> CGSize {
        
        return customSize(at: indexPath)
    }
}
