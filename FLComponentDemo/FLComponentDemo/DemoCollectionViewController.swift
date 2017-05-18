//
//  DemoCollectionViewController.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoCollectionViewController: FLCollectionComponentController {
    
    var flag : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "gitKong"
        
        var arr : Array<FLCollectionBaseComponent> = []
        
        let component = DemoCollectionComponentOne(collectionView: collectionView)
        arr.append(component)
        arr.append(DemoCollectionComponentTwo(collectionView: collectionView))
        arr.append(component)
        arr.append(DemoCollectionComponentTwo(collectionView: collectionView))
        arr.append(DemoCollectionComponentOne(collectionView: collectionView))
        self.components = arr
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "change", style: .done, target: self, action: #selector(self.change))
        
    }
    
    func change() {
        if self.flag {
            self.changeLayout(to: .System)
            self.title = "system style"
        }
        else {
            self.changeLayout(to: .Custom)
            self.title = "custom style"
        }
        self.flag = !self.flag
    }
    
    override var flowLayoutStyle: FLCollectionViewFlowLayoutStyle {
        return .Custom
    }

    override func flowLayoutConfiguration(_ flowLayout: FLCollectionViewFlowLayout) {
//        super.flowLayoutConfiguration(flowLayout)
//        flowLayout.itemSize = CGSize.init(width: 60, height: 60)
    }
    
    

}
