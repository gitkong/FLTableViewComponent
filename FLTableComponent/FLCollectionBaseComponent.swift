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
    
    var section : Int? = 0
    
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
    
    func cellForItem(at item: Int) -> UICollectionViewCell {
        return (collectionView?.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: IndexPath.init(item: item, section: section!)))!
    }
    
    
    /// If you do not override this method, the flow layout uses the values in its itemSize property to set the size of items instead. Your implementation of this method can return a fixed set of sizes or dynamically adjust the sizes based on the cell’s content.
    ///
    /// - Parameters:
    ///   - collectionViewLayout: Default is flowLayout
    ///   - indexPath: current indexPath
    /// - Returns: item size,default is (50.0, 50.0)
    func sizeForItem(at item: Int) -> CGSize {
        guard self.collectionView != nil, self.collectionView?.collectionViewLayout is FLCollectionViewFlowLayout else {
            return .zero
        }
        let flowLayout = self.collectionView!.collectionViewLayout as! FLCollectionViewFlowLayout
        return flowLayout.itemSize
    }
    
    
}

// MARK : Header and Footer customization

extension FLCollectionBaseComponent {
    
    func heightForHeader() -> CGFloat {
        return 0
    }
    
    func heightForFooter() -> CGFloat {
        return 0
    }
    
    func headerView() -> UICollectionReusableView {
        return (collectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.headerIdentifier, for: IndexPath.init(row: 0, section: section!)))!
    }
    
    func footerView() -> UICollectionReusableView {
        return (collectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: self.footerIdentifier, for: IndexPath.init(row: 0, section: section!)))!
    }
    
    final func collectionView(viewOfKind kind: String) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            return self.headerView()
        }
        else if kind == UICollectionElementKindSectionFooter {
            return self.footerView()
        }
        else {
            return UICollectionReusableView()
        }
    }
}

// MARK : Base UI Customization

extension FLCollectionBaseComponent {
    
    func sectionInset() -> UIEdgeInsets {
        guard self.collectionView != nil, self.collectionView?.collectionViewLayout is FLCollectionViewFlowLayout else {
            return .zero
        }
        let flowLayout = self.collectionView!.collectionViewLayout as! FLCollectionViewFlowLayout
        return flowLayout.sectionInset
    }
    
    func minimumLineSpacing() -> CGFloat {
        guard self.collectionView != nil, self.collectionView?.collectionViewLayout is FLCollectionViewFlowLayout else {
            return 0
        }
        let flowLayout = self.collectionView!.collectionViewLayout as! FLCollectionViewFlowLayout
        return flowLayout.minimumLineSpacing
    }
    
    func minimumInteritemSpacing() -> CGFloat {
        guard self.collectionView != nil, self.collectionView?.collectionViewLayout is FLCollectionViewFlowLayout else {
            return 0
        }
        let flowLayout = self.collectionView!.collectionViewLayout as! FLCollectionViewFlowLayout
        return flowLayout.minimumInteritemSpacing
    }
}


extension FLCollectionBaseComponent {
    
    func collectionView(willDisplayCell cell: UICollectionViewCell, at item: Int) {
        // do nothing
    }
    
    func collectionView(didEndDisplayCell cell: UICollectionViewCell, at item: Int) {
        
    }
    
    func collectionView(willDisplayHeaderView view: UICollectionReusableView) {
        
    }
    
    func collectionView(didEndDisplayHeaderView view: UICollectionReusableView) {
        
    }
    
    func collectionView(willDisplayFooterView view: UICollectionReusableView) {
        
    }
    
    func collectionView(didEndDisplayFooterView view: UICollectionReusableView) {
        
    }
    
    final func collectionView(willDisplayView view : UICollectionReusableView, viewOfKind kind: String) {
        
        if kind == UICollectionElementKindSectionHeader {
            self.collectionView(willDisplayHeaderView: view)
        }
        else if kind == UICollectionElementKindSectionFooter {
            self.collectionView(willDisplayHeaderView: view)
        }
    }
    
    final func collectionView(didEndDisplayView view : UICollectionReusableView, viewOfKind kind: String) {
        
        if kind == UICollectionElementKindSectionHeader {
            self.collectionView(didEndDisplayHeaderView: view)
        }
        else if kind == UICollectionElementKindSectionFooter {
            self.collectionView(didEndDisplayHeaderView: view)
        }
    }
}


extension FLCollectionBaseComponent {
    
    func shouldShowMenu(at item: Int) -> Bool {
        return false
    }
    
    func canPerform(selector : Selector, forItemAt: Int, withSender: Any?) -> Bool {
        return false
    }
    
    func perform(selector : Selector, forItemAt: Int, withSender: Any?) {
        // do nothing
    }
}
