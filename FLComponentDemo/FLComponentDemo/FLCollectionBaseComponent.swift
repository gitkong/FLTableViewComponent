//
//  FLCollectionBaseComponent.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class FLCollectionBaseComponent: FLBaseComponent, FLCollectionComponentConfiguration{
    
    var collectionView : UICollectionView?
    
    weak var componentController : FLTableComponentEvent?
    
    init(collectionView : UICollectionView){
        super.init()
        self.collectionView = collectionView
        // regist cell or header or footer
        self.register()
    }
}

// MARK : base configuration

extension FLCollectionBaseComponent {
    
    override func register() {
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.headerIdentifier)
        collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: self.footerIdentifier)
    }
    
    func numberOfItems() -> NSInteger {
        return 0
    }
    
    func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell {
        return (collectionView?.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath))!
    }
    
    
    /// If you do not override this method, the flow layout uses the values in its itemSize property to set the size of items instead. Your implementation of this method can return a fixed set of sizes or dynamically adjust the sizes based on the cell’s content.
    ///
    /// - Parameters:
    ///   - collectionViewLayout: Default is flowLayout
    ///   - indexPath: current indexPath
    /// - Returns: item size
    func sizeForItem(withLayout collectionViewLayout: UICollectionViewLayout, at indexPath: IndexPath) -> CGSize {
        return CGSize.zero
    }
    
    
}


extension FLCollectionBaseComponent {
    
    func heightForHeader(at section : Int) -> CGFloat {
        return 0
    }
    
    func heightForFooter(at section : Int) -> CGFloat {
        return 0
    }
    
    func headerView(at section : Int) -> UICollectionReusableView {
        return (collectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.headerIdentifier, for: IndexPath.init(row: 0, section: section)))!
    }
    
    func footerView(at section : Int) -> UICollectionReusableView {
        return (collectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: self.footerIdentifier, for: IndexPath.init(row: 0, section: section)))!
    }
    
    final func collectionView(viewOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            return self.headerView(at: indexPath.section)
        }
        else if kind == UICollectionElementKindSectionFooter {
            return self.footerView(at: indexPath.section)
        }
        else {
            return UICollectionReusableView()
        }
    }
}

