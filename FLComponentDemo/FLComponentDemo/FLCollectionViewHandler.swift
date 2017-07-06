//
//  FLCollectionViewHandler.swift
//  FLComponentDemo
//
//  Created by 孔凡列 on 2017/6/19.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

import UIKit

@objc protocol FLCollectionViewHandlerDelegate {
    @objc optional func collectionViewDidClick(_ handler : FLCollectionViewHandler, itemAt indexPath : IndexPath)
    @objc optional func collectionViewDidClick(_ handler : FLCollectionViewHandler, headerAt section : NSInteger)
    @objc optional func collectionViewDidClick(_ handler : FLCollectionViewHandler, footerAt section : NSInteger)
}

class FLCollectionViewHandler: NSObject {
    
    private(set) lazy var componentsDict : NSMutableDictionary = {
        return NSMutableDictionary.init()
    }()
    
    var components : Array<FLCollectionBaseComponent> = [] {
        didSet {
            self.collectionView?.handler = self
            componentsDict.removeAllObjects()
            for section in 0..<components.count {
                let component = components[section]
                component.section = section
                // same key will override the old value, so the last component will alaways remove first
                componentsDict.setValue(component, forKey: component.componentIdentifier)
            }
        }
    }
    
    var delegate : FLCollectionViewHandlerDelegate?
    
    var collectionView : UICollectionView? {
        return components.first?.collectionView
    }
}

// Mark : component control

extension FLCollectionViewHandler {
    func component(at index : NSInteger) -> FLCollectionBaseComponent? {
        guard components.count > 0, index < components.count else {
            return nil
        }
        return components[index]
    }
    
    func removeComponent(by identifier : String, removeType : FLComponentRemoveType) {
        guard components.count > 0 else {
            return
        }
        if let component = self.component(by: identifier) {
            self.componentsDict.removeObject(forKey: identifier)
            if removeType == .All {
                self.components = self.components.filter({ $0 != component })
            }
            else if removeType == .Last {
                self.removeComponent(component)
            }
        }
    }
    
    func removeComponent(_ component : FLCollectionBaseComponent?) {
        guard component != nil else {
            return
        }
        self.removeComponent(at: component!.section!)
    }
    
    func removeComponent(at index : NSInteger) {
        guard  index < components.count else {
            return
        }
        self.components.remove(at: index)
    }
    
    func reloadComponents() {
        self.collectionView?.reloadData()
    }
    
    func reloadComponent(_ component : FLCollectionBaseComponent) {
        self.reloadComponent(at: component.section!)
    }
    
    func reloadComponent(at index : NSInteger) {
        guard components.count > 0, index < components.count else {
            return
        }
        self.collectionView?.reloadSections(IndexSet.init(integer: index))
    }
    
    func component(by identifier : String) -> FLCollectionBaseComponent? {
        guard componentsDict.count > 0, !identifier.isEmpty else {
            return nil
        }
        return componentsDict.value(forKey: identifier) as? FLCollectionBaseComponent
    }
}

// MARK : dataSources customizaion

extension FLCollectionViewHandler : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    final func numberOfSections(in collectionView: UICollectionView) -> Int {
        return components.count
    }
    
    final func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard components.count > 0 else {
            return 0
        }
        return components[section].numberOfItems()
    }
    
    final func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard components.count > 0 else {
            return UICollectionViewCell()
        }
        let component : FLCollectionBaseComponent = components[indexPath.section]
        component.section = indexPath.section
        return component.cellForItem(at: indexPath.item)
    }
}

// MARK : display method customizaion

extension FLCollectionViewHandler : UICollectionViewDelegate {
    
    final func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard components.count > 0, indexPath.section < components.count else {
            return
        }
        components[indexPath.section].collectionView(willDisplayCell: cell, at: indexPath.item)
    }
    
    final func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard components.count > 0, indexPath.section < components.count else {
            return
        }
        components[indexPath.section].collectionView(didEndDisplayCell: cell, at: indexPath.item)
    }
    
    final func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard components.count > 0, indexPath.section < components.count else {
            return
        }
        components[indexPath.section].collectionView(willDisplayView: view as! FLCollectionHeaderFooterView, viewOfKind: elementKind)
    }
    
    final func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath){
        guard components.count > 0, indexPath.section < components.count else {
            return
        }
        components[indexPath.section].collectionView(didEndDisplayView: view as! FLCollectionHeaderFooterView, viewOfKind: elementKind)
    }
}


// MARK : header or footer customizaion

extension FLCollectionViewHandler {
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard components.count > 0, section < components.count else {
            return CGSize.zero
        }
        return CGSize.init(width: collectionView.bounds.size.width,
                           height: components[section].heightForHeader())
    }
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard components.count > 0, section < components.count else {
            return CGSize.zero
        }
        return CGSize.init(width: collectionView.bounds.size.width,
                           height: components[section].heightForFooter())
    }
    
    final func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard components.count > 0, indexPath.section < components.count else {
            return UICollectionReusableView()
        }
        let component = components[indexPath.section]
        let headerFooterView :FLCollectionHeaderFooterView = component.collectionView(viewOfKind: kind)
        headerFooterView.delegate = self
        headerFooterView.section = indexPath.section
        // add gesture
        let tapG : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.headerFooterDidClick))
        headerFooterView.addGestureRecognizer(tapG)
        return headerFooterView
    }
    
    func headerFooterDidClick(GesR : UIGestureRecognizer) {
        let headerFooterView : FLCollectionHeaderFooterView = GesR.view as! FLCollectionHeaderFooterView
        guard let identifierType = FLIdentifierType.type(of: headerFooterView.reuseIdentifier) , let section = headerFooterView.section else {
            return
        }
        switch identifierType {
        case .Header:
            self.collectionHeaderView(headerFooterView, didClickSectionAt: section)
        case .Footer:
            self.collectionFooterView(headerFooterView, didClickSectionAt: section)
        default : break
        }
    }
    
}

// MARK : layout customization

extension FLCollectionViewHandler {
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard components.count > 0, indexPath.section < components.count else {
            return CGSize.zero
        }
        var size : CGSize = components[indexPath.section].sizeForItem(at: indexPath.item)
        if size == .zero {
            if self.collectionView?.collectionViewLayout is FLCollectionViewFlowLayout {
                let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                size = flowLayout.itemSize
            }
            else {
                size = (collectionViewLayout.layoutAttributesForItem(at: indexPath) != nil) ? collectionViewLayout.layoutAttributesForItem(at: indexPath)!.size : CGSize.zero
            }
        }
        return size
    }
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard components.count > 0, section < components.count else {
            return UIEdgeInsets.zero
        }
        
        let inset : UIEdgeInsets = components[section].sectionInset()
        // set sectionInset, because custom flowLayout can not get that automatily
        if let flowLayout = self.collectionView?.collectionViewLayout as? FLCollectionViewFlowLayout {
            flowLayout.sectionInsetArray.append(inset)
        }
        return inset
    }
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard components.count > 0, section < components.count else {
            return 0
        }
        let minimumLineSpacing : CGFloat = components[section].minimumLineSpacing()
        // set minimumLineSpacing, because custom flowLayout can not get that automatily
        if let flowLayout = self.collectionView?.collectionViewLayout as? FLCollectionViewFlowLayout {
            flowLayout.minimumLineSpacingArray.append(minimumLineSpacing)
        }
        return minimumLineSpacing
    }
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard components.count > 0, section < components.count else {
            return 0
        }
        let minimumInteritemSpacing : CGFloat = components[section].minimumInteritemSpacing()
        // set minimumInteritemSpacing, because custom flowLayout can not get that automatily
        if let flowLayout = self.collectionView?.collectionViewLayout as? FLCollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacingArray.append(minimumInteritemSpacing)
        }
        return minimumInteritemSpacing
    }
    
}

// MARK : Managing Actions for Cells

extension FLCollectionViewHandler {
    
    final func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        guard components.count > 0, indexPath.section < components.count else {
            return false
        }
        return components[indexPath.section].shouldShowMenu(at: indexPath.item)
    }
    
    final func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        guard components.count > 0, indexPath.section < components.count else {
            return false
        }
        return components[indexPath.section].canPerform(selector: action, forItemAt: indexPath.item, withSender: sender)
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        guard components.count > 0, indexPath.section < components.count else {
            return
        }
        components[indexPath.section].perform(selector: action, forItemAt: indexPath.item, withSender: sender)
    }
    
}

// MARK ：Event

extension FLCollectionViewHandler : FLCollectionComponentEvent {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.collectionViewDidClick?(self, itemAt: indexPath)
    }
    
    func collectionHeaderView(_ headerView: FLCollectionHeaderFooterView, didClickSectionAt section: Int) {
        self.delegate?.collectionViewDidClick?(self, headerAt: section)
    }
    
    func collectionFooterView(_ footerView: FLCollectionHeaderFooterView, didClickSectionAt section: Int) {
        self.delegate?.collectionViewDidClick?(self, footerAt: section)
    }
}

