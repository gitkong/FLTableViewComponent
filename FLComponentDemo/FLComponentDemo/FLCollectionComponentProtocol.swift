//
//  FLCollectionComponentProtocol.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

@objc protocol FLCollectionComponentConfiguration : FLBaseComponentProtocol{
    
    // custom UI,default collectionViewlayout is flowLayout, you can override the flowLayoutConfiguration method to custom flowLayout
    
    @objc optional var collectionViewLayout : UICollectionViewLayout { get }
    
    @objc optional func flowLayoutConfiguration(_ flowLayout : FLCollectionViewFlowLayout)
    
    @objc optional var flowLayoutStyle : FLCollectionViewFlowLayoutStyle { get set }
    
    @objc optional func sectionInset(at section : Int) -> UIEdgeInsets
    
    @objc optional func minimumLineSpacing(at section : Int) -> CGFloat
    
    @objc optional func minimumInteritemSpacing(at section : Int) -> CGFloat
    
    // dataSource configuration
    
    @objc optional func numberOfItems() -> NSInteger
    
    @objc optional func cellForItem(at item: Int) -> UICollectionViewCell
    
    @objc optional func sizeForItem(withLayout collectionViewLayout: UICollectionViewLayout, at item: Int) -> CGSize
    
    // header or footer view customization
    
    @objc optional func headerView(at section : Int) -> UICollectionReusableView
    
    @objc optional func footerView(at section : Int) -> UICollectionReusableView
    
    @objc optional func heightForHeader(at section : Int) -> CGFloat
    
    @objc optional func heightForFooter(at section : Int) -> CGFloat
    
    //
}
