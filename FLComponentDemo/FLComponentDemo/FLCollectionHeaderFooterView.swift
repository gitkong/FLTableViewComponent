//
//  FLCollectionReusableView.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/22.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

@objc protocol FLCollectionHeaderFooterViewDelegate {
    func headerFooterViewDidClick(_ headerFooterView : FLCollectionHeaderFooterView, atSection : NSInteger)
}

class FLCollectionHeaderFooterView: UICollectionReusableView, FLCollectionComponentConfiguration {
    
    /// get component and type for reuse before the method init(frame:) call
    static weak var component : FLCollectionBaseComponent?
    static var type : FLIdentifierType?
    weak var delegate : FLCollectionComponentEvent?
    public var section : Int?
    
    // MARK : if you want header or footer view have accurate event handling capabilities, you should initialize with init(reuseIdentifier: String?, section: Int)
    convenience init(frame: CGRect, section: Int){
        self.init(frame: frame)
        self.section = section
    }
    
    // MARK : dequeue will call init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add gesture
        let tapG : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.headerFooterDidClick))
        self.addGestureRecognizer(tapG)
        
        // need to know self is header or footer
        // custom reuse UI, need to init here
        if FLCollectionHeaderFooterView.type == .Header {
            FLCollectionHeaderFooterView.component?.additionalOperationForReuseHeaderView(self)
        }
        else if FLCollectionHeaderFooterView.type == .Footer {
            FLCollectionHeaderFooterView.component?.additionalOperationForReuseFooterView(self)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func headerFooterDidClick() {
        
        guard let identifierType = FLIdentifierType.type(of: self.reuseIdentifier) , let section = section else {
            return
        }
        
        switch identifierType {
        case .Header:
            FLCollectionHeaderFooterView.component?.handler?.collectionHeaderView!(self, didClickSectionAt: section)
        case .Footer:
            FLCollectionHeaderFooterView.component?.handler?.collectionFooterView!(self, didClickSectionAt: section)
        default : break
        }
    }
}
