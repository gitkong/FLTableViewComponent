//
//  FLCollectionViewCell.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/25.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class FLCollectionViewCell: UICollectionViewCell {
    
    static var component : FLCollectionBaseComponent?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        FLCollectionViewCell.component?.additionalOperationForReuseCell(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
