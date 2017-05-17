//
//  DemoCollectionViewController.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoCollectionViewController: FLCollectionComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var arr : Array<FLCollectionBaseComponent> = []
        
        let component = DemoCollectionComponentOne(collectionView: collectionView)
        arr.append(component)
//        arr.append(component)
//        arr.append(component)
        
        self.components = arr
    }

    override func flowLayoutConfiguration(_ flowLayout: UICollectionViewFlowLayout) {
        flowLayout.itemSize = CGSize.init(width: 60, height: 60)
    }
    
    

}
