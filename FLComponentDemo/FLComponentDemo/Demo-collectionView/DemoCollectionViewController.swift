//
//  DemoCollectionViewController.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoCollectionViewController: FLCollectionComponentController{
    
    var flag : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "gitKong"
        
        var arr : Array<FLCollectionBaseComponent> = []
        
        let component = DemoCollectionComponentOne.init(collectionView: collectionView, identifier : "gitKong_DemoCollection")
        arr.append(component)
        arr.append(DemoCollectionComponentTwo(collectionView: collectionView, identifier : "gitKong_Demo_Two_collection"))
//        arr.append(component)
//        arr.append(DemoCollectionComponentTwo(collectionView: collectionView))
//        arr.append(component)
//        arr.append(DemoCollectionComponentTwo(collectionView: collectionView))
        self.components = arr
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "change", style: .done, target: self, action: #selector(self.change))
        
    }
    
    func change() {
        if self.flag {
            self.flowLayoutStyle = .System
            self.title = "system style"
        }
        else {
            self.flowLayoutStyle = .Custom
            self.title = "custom style"
        }
        self.flag = !self.flag
        
        // Delete Test
        if let firstComponent = self.handler.component(by: "gitKong_DemoCollection"), let secondComponent = self.handler.component(by: "gitKong_Demo_Two_collection") {
            self.handler.exchange(firstComponent, by: secondComponent)
        }
        
//        self.handler.removeComponent(by: "gitKong_DemoCollection", removeType: .All)
    }

    override func flowLayoutConfiguration(_ flowLayout: FLCollectionViewFlowLayout) {
//        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        flowLayout.itemSize = CGSize.init(width: 100, height: 100)
        flowLayout.flowLayoutStyle = .Custom
        if #available(iOS 9.0, *) {
            flowLayout.sectionHeadersPinToVisibleBounds = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    func test<T>() -> T {
        return self as! T
    }

}
