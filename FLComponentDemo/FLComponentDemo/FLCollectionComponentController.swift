//
//  FLCollectionComponentController.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class FLCollectionComponentController: UIViewController{
    
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

extension FLCollectionComponentController : FLCollectionComponentConfiguration {
    
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

extension FLCollectionComponentController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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

// MARK : header or footer customizaion

extension FLCollectionComponentController {
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard components.count > 0 else {
            return CGSize.zero
        }
        return CGSize.init(width: collectionView.bounds.size.width,
                           height: components[section].heightForHeader(at: section))
    }
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard components.count > 0 else {
            return CGSize.zero
        }
        return CGSize.init(width: collectionView.bounds.size.width,
                           height: components[section].heightForFooter(at: section))
    }
    
    final func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard components.count > 0 else {
            return UICollectionReusableView()
        }
        return components[indexPath.section].collectionView(viewOfKind: kind, at: indexPath)
    }
    
}

// MARK : layout customization

extension FLCollectionComponentController {
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard components.count > 0 else {
            return CGSize.zero
        }
        var size : CGSize = components[indexPath.section].sizeForItem(withLayout: collectionViewLayout, at: indexPath.item)
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
        
        let inset : UIEdgeInsets = components[section].sectionInset(at: section)
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
        let minimumLineSpacing : CGFloat = components[section].minimumLineSpacing(at: section)
        // set minimumLineSpacing, because custom flowLayout can not get that automatily
        if let flowLayout = self.collectionView.collectionViewLayout as? FLCollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = minimumLineSpacing
        }
        return minimumLineSpacing
    }
    
    final func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard components.count > 0 else {
            return 0
        }
        let minimumInteritemSpacing : CGFloat = components[section].minimumInteritemSpacing(at: section)
        // set minimumInteritemSpacing, because custom flowLayout can not get that automatily
        if let flowLayout = self.collectionView.collectionViewLayout as? FLCollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        }
        return minimumInteritemSpacing
    }
}
