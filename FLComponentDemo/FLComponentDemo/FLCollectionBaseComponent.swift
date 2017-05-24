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
        collectionView?.registerClass(UICollectionViewCell.self, withReuseIdentifier: cellIdentifier)
        collectionView?.registerClass(FLCollectionHeaderFooterView.self, withReuseIdentifier: headerIdentifier)
        collectionView?.registerClass(FLCollectionHeaderFooterView.self, withReuseIdentifier: footerIdentifier)
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
    
    func headerView() -> FLCollectionHeaderFooterView {
        guard let collectionView = collectionView ,let section = section else {
            return FLCollectionHeaderFooterView(frame: .zero)
        }
        
//        if let flag = self.responds(to: #selector(collectionView.register(_:forSupplementaryViewOfKind:withReuseIdentifier:)))  {
//            
//        }
        
        var headerView = collectionView.dequeueReusableHeaderFooterView(withReuseIdentifier: headerIdentifier, section: section)
        
        
        if headerView == nil {
            headerView = FLCollectionHeaderFooterView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: collectionView.bounds.size.width,height: self.heightForHeader())), reuseIdentifier: headerIdentifier, section: section)
            additionalOperationForReuseHeaderView(headerView)
            headerView?.prepareForReuse()
        }
        
        return headerView!
    }
    
    func footerView() -> FLCollectionHeaderFooterView {
        guard collectionView != nil, let section = section else {
            return FLCollectionHeaderFooterView(frame: CGRect.zero)
        }
        
        var footerView = collectionView?.dequeueReusableHeaderFooterView(withReuseIdentifier: footerIdentifier, section: section)
        if footerView == nil {
            footerView = FLCollectionHeaderFooterView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: collectionView!.bounds.size.width,height: self.heightForFooter())), reuseIdentifier: self.footerIdentifier, section: section)
            additionalOperationForReuseFooterView(footerView)
            footerView?.prepareForReuse()
        }
        
        return footerView!
    }
    
    func additionalOperationForReuseHeaderView(_ headerView : FLCollectionHeaderFooterView?) {
        
    }
    
    func additionalOperationForReuseFooterView(_ footerView : FLCollectionHeaderFooterView?) {
        
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


