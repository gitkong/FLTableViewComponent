//
//  FLCollectionComponentController.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class FLCollectionComponentController: UIViewController {
    
    private(set) var handler : FLCollectionViewHandler = FLCollectionViewHandler.init()
    
    lazy var collectionView : UICollectionView = {
        let collectionView : UICollectionView = UICollectionView.init(frame: self.customRect, collectionViewLayout: self.collectionViewLayout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    var components : Array<FLCollectionBaseComponent> = []{
        didSet {
            handler.components = components
        }
    }
    
    final var flowLayoutStyle: FLCollectionViewFlowLayoutStyle = .System{
        didSet {
            guard self.collectionView.collectionViewLayout is FLCollectionViewFlowLayout else {
                return
            }
            let flowLayout = self.collectionView.collectionViewLayout as! FLCollectionViewFlowLayout
            flowLayout.delegate = handler
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
        if self.collectionView.collectionViewLayout is FLCollectionViewFlowLayout {
            let layout = self.collectionViewLayout as! FLCollectionViewFlowLayout
            layout.delegate = handler
        }
        handler.delegate = self
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
        flowLayout.delegate = handler
        flowLayoutConfiguration(flowLayout)
        return flowLayout
    }
    
    final func reloadComponent() {
        handler.reloadComponents()
    }
}

extension FLCollectionComponentController : FLCollectionViewHandlerDelegate {
    
    func collectionViewDidClick(_ handler: FLCollectionViewHandler, itemAt indexPath: IndexPath) {
        // subclass override it
    }
    
    func collectionViewDidClick(_ handler: FLCollectionViewHandler, headerAt section: NSInteger) {
        // subclass override it
    }
    
    func collectionViewDidClick(_ handler: FLCollectionViewHandler, footerAt section: NSInteger) {
        // subclass override it
    }
}

