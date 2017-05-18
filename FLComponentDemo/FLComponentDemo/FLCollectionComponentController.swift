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
    
    var flowLayoutStyle: FLCollectionViewFlowLayoutStyle {
        return .System
    }
    
    var collectionViewLayout: UICollectionViewLayout {
        let flowLayout : FLCollectionViewFlowLayout = FLCollectionViewFlowLayout.init(with: self.flowLayoutStyle)
        flowLayout.delegate = self
        flowLayoutConfiguration(flowLayout)
        return flowLayout
    }
    
    func changeLayout(to layoutStyle : FLCollectionViewFlowLayoutStyle) {
        let flowLayout : FLCollectionViewFlowLayout = FLCollectionViewFlowLayout.init(with: layoutStyle)
        flowLayout.delegate = self
        flowLayoutConfiguration(flowLayout)
        self.collectionView.setCollectionViewLayout(flowLayout, animated: true) { (finish) in
            self.reloadComponent()
        }
    }
    
    func reloadComponent() {
        self.collectionView.reloadData()
    }
}

// MARK : dataSources customizaion

extension FLCollectionComponentController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return components.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard components.count > 0 else {
            return 0
        }
        return components[section].numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard components.count > 0 else {
            return UICollectionViewCell()
        }
        return components[indexPath.section].cellForItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard components.count > 0 else {
            return CGSize.zero
        }
        var size : CGSize = components[indexPath.section].sizeForItem(withLayout: collectionViewLayout, at: indexPath)
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
}

// MARK : header or footer customizaion

extension FLCollectionComponentController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard components.count > 0 else {
            return CGSize.zero
        }
        return CGSize.init(width: collectionView.bounds.size.width,
                           height: components[section].heightForHeader(at: section))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard components.count > 0 else {
            return CGSize.zero
        }
        return CGSize.init(width: collectionView.bounds.size.width,
                           height: components[section].heightForFooter(at: section))
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard components.count > 0 else {
            return UICollectionReusableView()
        }
        return components[indexPath.section].collectionView(viewOfKind: kind, at: indexPath)
    }
    
}
