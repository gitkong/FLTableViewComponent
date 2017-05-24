//
//  FLCollectionReusableView.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/22.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class FLCollectionHeaderFooterView: UICollectionReusableView {
    
    public var section : Int?
    
    weak var delegate : FLCollectionComponentEvent?
    
    public var identifier : String?
    
    override var reuseIdentifier: String? {
        return self.identifier
    }
    
    convenience init(frame: CGRect, reuseIdentifier: String?, section: Int){
        self.init(frame: frame)
        self.identifier = reuseIdentifier
        self.section = section
    }
    
    // MARK : dequeue will call init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add gesture
        let tapG : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.headerFooterDidClick))
        
        self.addGestureRecognizer(tapG)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func headerFooterDidClick() {
        guard let identifierType = FLIdentifierType.type(of: identifier) , let section = self.section else {
            return
        }
        switch identifierType {
        case .Header:
            delegate?.collectionHeaderView!(self, didClickSectionAt: section)
        case .Footer:
            delegate?.collectionFooterView!(self, didClickSectionAt: section)
        default : break
        }
    }
}
