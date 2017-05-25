//
//  FLCollectionComponentController.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class FLCollectionComponentController: UIViewController, FLCollectionComponentConfiguration{
    
    lazy var collectionView : UICollectionView = {
        let collectionView : UICollectionView = UICollectionView.init(frame: self.customRect, collectionViewLayout: self.collectionViewLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var components : Array<FLCollectionBaseComponent> = []{
        didSet {
            
        }
    }
    
    final var flowLayoutStyle: FLCollectionViewFlowLayoutStyle = .System{
        didSet {
            guard self.collectionView.collectionViewLayout is FLCollectionViewFlowLayout else {
                return
            }
            let flowLayout = self.collectionView.collectionViewLayout as! FLCollectionViewFlowLayout
            flowLayout.delegate = self
            self.flowLayoutConfiguration(flowLayout)
            flowLayout.flowLayoutStyle = flowLayoutStyle
            self.reloadComponent()
            
            // MARK : set animate will Crash，https://bugs.swift.org/browse/SR-2417
//            self.collectionView.collectionViewLayout.invalidateLayout()
//            self.collectionView.layoutIfNeeded()
//            let flowLayout = FLCollectionViewFlowLayout.init(with: flowLayoutStyle)
//            flowLayout.delegate = self
//            self.collectionView.setCollectionViewLayout(flowLayout, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = self.customRect
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
    }
    
    
}

extension FLCollectionComponentController {
    
    var customRect: CGRect {
        return self.view.bounds
    }
    
    func flowLayoutConfiguration(_ flowLayout: FLCollectionViewFlowLayout) {
        // do somethings
    }
    
    var collectionViewLayout: UICollectionViewLayout {
        let flowLayout : FLCollectionViewFlowLayout = FLCollectionViewFlowLayout.init(with: self.flowLayoutStyle)
        flowLayout.delegate = self
        flowLayoutConfiguration(flowLayout)
        return flowLayout
    }
    
    final func reloadComponent() {
        self.collectionView.reloadData()
    }
}

// MARK : dataSources customizaion

extension FLCollectionComponentController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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

extension FLCollectionComponentController : UICollectionViewDelegate {
    
    final func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard components.count > 0 else {
            return
        }
        components[indexPath.section].collectionView(willDisplayCell: cell, at: indexPath.item)
    }
    
    final func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard components.count > 0 else {
            return
        }
        components[indexPath.section].collectionView(didEndDisplayCell: cell, at: indexPath.item)
    }
    
    final func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard components.count > 0 else {
            return
        }
        components[indexPath.section].collectionView(willDisplayView: view as! FLCollectionHeaderFooterView, viewOfKind: elementKind)
    }
    
    final func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath){
        guard components.count > 0 else {
            return
        }
        components[indexPath.section].collectionView(didEndDisplayView: view as! FLCollectionHeaderFooterView, viewOfKind: elementKind)
    }
}


// MARK : header or footer customizaion

extension FLCollectionComponentController: FLCollectionComponentEvent {
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard components.count > 0 else {
            return CGSize.zero
        }
        return CGSize.init(width: collectionView.bounds.size.width,
                           height: components[section].heightForHeader())
    }
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard components.count > 0 else {
            return CGSize.zero
        }
        return CGSize.init(width: collectionView.bounds.size.width,
                           height: components[section].heightForFooter())
    }
    
    final func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard components.count > 0 else {
            return UICollectionReusableView()
        }
        let component = components[indexPath.section]
        component.componentController = self
        return component.collectionView(viewOfKind: kind)
    }
    
    func collectionHeaderView(_ headerView: FLCollectionHeaderFooterView, didClickSectionAt section: Int) {
        // do something
        print("header(\(section)) : hello gitKong");
    }
    
    func collectionFooterView(_ footerView: FLCollectionHeaderFooterView, didClickSectionAt section: Int) {
        // do something
        print("footer(\(section)) : hello gitKong");
    }
    
}

// MARK : layout customization

extension FLCollectionComponentController {
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard components.count > 0 else {
            return CGSize.zero
        }
        var size : CGSize = components[indexPath.section].sizeForItem(at: indexPath.item)
        if size == .zero {
            if self.collectionViewLayout is FLCollectionViewFlowLayout {
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
        guard components.count > 0 else {
            return UIEdgeInsets.zero
        }
        
        let inset : UIEdgeInsets = components[section].sectionInset()
        // set sectionInset, because custom flowLayout can not get that automatily
        if let flowLayout = self.collectionView.collectionViewLayout as? FLCollectionViewFlowLayout {
            flowLayout.sectionInsetArray.append(inset)
        }
        return inset
    }
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard components.count > 0 else {
            return 0
        }
        let minimumLineSpacing : CGFloat = components[section].minimumLineSpacing()
        // set minimumLineSpacing, because custom flowLayout can not get that automatily
        if let flowLayout = self.collectionView.collectionViewLayout as? FLCollectionViewFlowLayout {
            flowLayout.minimumLineSpacingArray.append(minimumLineSpacing)
        }
        return minimumLineSpacing
    }
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard components.count > 0 else {
            return 0
        }
        let minimumInteritemSpacing : CGFloat = components[section].minimumInteritemSpacing()
        // set minimumInteritemSpacing, because custom flowLayout can not get that automatily
        if let flowLayout = self.collectionView.collectionViewLayout as? FLCollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacingArray.append(minimumInteritemSpacing)
        }
        return minimumInteritemSpacing
    }
    
}

// MARK : Managing Actions for Cells

extension FLCollectionComponentController {
    
    final func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        guard components.count > 0 else {
            return false
        }
        return components[indexPath.section].shouldShowMenu(at: indexPath.item)
    }
    
    final func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        guard components.count > 0 else {
            return false
        }
        return components[indexPath.section].canPerform(selector: action, forItemAt: indexPath.item, withSender: sender)
    }
    
    // you can override this method 
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        guard components.count > 0 else {
            return
        }
        components[indexPath.section].perform(selector: action, forItemAt: indexPath.item, withSender: sender)
    }
    
}

