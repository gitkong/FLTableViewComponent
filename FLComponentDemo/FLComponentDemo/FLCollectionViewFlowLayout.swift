//
//  FLCollectionViewFlowLayout.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/18.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

typealias LayoutAttributesArray = Array<UICollectionViewLayoutAttributes>?

typealias LayoutAttributesDict = Dictionary<FLIdentifierType , LayoutAttributesArray>?

@objc enum FLCollectionViewFlowLayoutStyle : NSInteger{
    case System = 0// System style, Both ends of the same spacing, the middle spacing is not equal, alignment is center
    case Custom = 1// Both ends of spacing is not equal, the middle spacing is equal, alignment is top
}

class FLCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    weak var delegate : UICollectionViewDelegateFlowLayout?
    
    private var sectionAttributes : Array<LayoutAttributesDict> = []
    
    var flowLayoutStyle : FLCollectionViewFlowLayoutStyle?{
        didSet {
            // reset 
            verticalTotalItemMaxY = 0
        }
    }
    
    var verticalTotalItemMaxY : CGFloat = 0
    
    var sectionInsetArray : Array<UIEdgeInsets> = []
    var minimumInteritemSpacingArray : Array<CGFloat> = []
    var minimumLineSpacingArray : Array<CGFloat> = []
    
    convenience init(with flowLayoutStyle : FLCollectionViewFlowLayoutStyle = .System) {
        self.init()
        self.flowLayoutStyle = flowLayoutStyle
    }
    
    override init() {
        super.init()
        self.scrollDirection = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        if flowLayoutStyle == .System {
            return
        }
        guard self.collectionView != nil , let sections = self.collectionView?.numberOfSections , self.delegate != nil else {
            return
        }
        
        sectionAttributes.removeAll()
        
        var currentInset : UIEdgeInsets = sectionInsetArray[0]
        var currentMinimumInteritemSpacing : CGFloat = minimumInteritemSpacingArray[0]
        var currentMinimumLineSpacing : CGFloat = minimumLineSpacingArray[0]
        
        var offsetX : CGFloat = currentInset.left
        var nextOffsetX : CGFloat = currentInset.left
        var offsetY : CGFloat = currentInset.top
        
        var currentRowMaxItemHeight : CGFloat = 0
        var lastHeaderAttributeSize : CGSize = CGSize.zero
        var lastFooterAttributeSize : CGSize = CGSize.zero
        
        for section in 0 ..< sections {
            
            var itemAttributes : LayoutAttributesArray = []
            var attributeDict : LayoutAttributesDict = [FLIdentifierType.Cell : itemAttributes]
            if let items = self.collectionView?.numberOfItems(inSection: section) {
                let headerAttributeSize : CGSize = (self.delegate?.collectionView!(self.collectionView!, layout: self, referenceSizeForHeaderInSection: section))!
                let headerAttribute = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: IndexPath.init(item: 0, section: section))
                headerAttribute.frame = CGRect.init(origin: CGPoint.init(x: 0, y: verticalTotalItemMaxY), size: headerAttributeSize)

                verticalTotalItemMaxY = 0
                
                let footerAttribute = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: IndexPath.init(item: 0, section: section))
                
                //print("----- section (\(section))  ------")
                
                for item in 0 ..< items {
                    let indexPath = IndexPath.init(item: item, section: section)
                    
                    let attribute = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                    if let itemSize = self.delegate?.collectionView!(self.collectionView!, layout: self, sizeForItemAt: indexPath) {
                        
                        nextOffsetX = nextOffsetX + currentMinimumInteritemSpacing + itemSize.width
                        
                        if nextOffsetX > self.collectionView!.bounds.size.width{
                            
                            offsetX = currentInset.left
                            nextOffsetX = currentInset.left + currentMinimumInteritemSpacing + itemSize.width
                            offsetY = offsetY + currentRowMaxItemHeight + currentMinimumLineSpacing
                            //print("max item height = \(currentRowMaxItemHeight)")
                            // next row , compare with last itemSize
                            currentRowMaxItemHeight = itemSize.height
                        }
                        else {
                            //print("compare : \(currentRowMaxItemHeight)  -  \(itemSize.height)")
                            currentRowMaxItemHeight = max(currentRowMaxItemHeight, itemSize.height)
                            offsetX = nextOffsetX - (currentMinimumInteritemSpacing + itemSize.width)
                        }
                        
                        attribute.frame = CGRect.init(x: offsetX, y: offsetY + headerAttribute.frame.size.height, width: itemSize.width, height: itemSize.height)
                        
                        
                        if item == items - 1 {
                            //print("last attribute frame : \(attribute.frame)")
                            verticalTotalItemMaxY = currentRowMaxItemHeight + attribute.frame.origin.y + currentInset.bottom
                            lastHeaderAttributeSize = headerAttribute.frame.size
                        }
                    }
                    itemAttributes!.append(attribute)
                }
                
                if let footerAttributeSize = self.delegate?.collectionView!(self.collectionView!, layout: self, referenceSizeForFooterInSection: section) {
                    if footerAttributeSize.height != 0 , footerAttributeSize.width != 0 {
                        //print("section : \(section), footerHeight : \(footerAttributeSize.height), verticalTotalItemMaxY : \(verticalTotalItemMaxY)")
                        footerAttribute.frame = CGRect.init(origin: CGPoint.init(x: 0, y: verticalTotalItemMaxY), size: footerAttributeSize)
                        
                        verticalTotalItemMaxY = verticalTotalItemMaxY + footerAttribute.frame.size.height
                        
                        if headerAttributeSize.height != 0 , headerAttributeSize.width != 0 {
                            //print("footer and header exist at section-\(section)")
                        }
                        else {
                            //print("footer exist at section-\(section), but header not")
                        }
                        
                        offsetY = verticalTotalItemMaxY - lastHeaderAttributeSize.height + headerAttribute.frame.size.height + currentMinimumLineSpacing
                        
                        lastFooterAttributeSize = footerAttribute.frame.size
                    }
                    else {
                        //print("section : \(section), headerAttribute : \(headerAttribute.size) verticalTotalItemMaxY : \(verticalTotalItemMaxY)")
                        offsetY = verticalTotalItemMaxY - lastHeaderAttributeSize.height + headerAttribute.frame.size.height + currentMinimumLineSpacing
                        if headerAttributeSize.height != 0 , headerAttributeSize.width != 0 {
                            //print("header exist at section-\(section), but footer not")
                        }
                        else {
                            //print("header and footer NOT exist at section-\(section)")
                            offsetY = offsetY + currentMinimumLineSpacing
                        }
                    }
                }
                else {
                    offsetY = verticalTotalItemMaxY - lastHeaderAttributeSize.height + headerAttribute.frame.size.height + currentMinimumLineSpacing
                }
                
                // if current header and last footer exist , just need to add minimumLineSpacing once
                if lastFooterAttributeSize.height == 0 , headerAttributeSize.height == 0 {
                    offsetY = offsetY - currentMinimumLineSpacing
                }
                
                // reset
                
                // next section, you should subtract the last section minimumLineSpacing
                offsetY = offsetY - currentMinimumLineSpacing
                
                if section < sections - 1 {
                    currentInset = sectionInsetArray[section + 1]
                    currentMinimumInteritemSpacing = minimumInteritemSpacingArray[section + 1]
                    currentMinimumLineSpacing = minimumLineSpacingArray[section + 1]
                }
                
                // add currentInset.top for next section offsetY
                offsetY = offsetY + currentInset.top
                
                offsetX = currentInset.left
                nextOffsetX = offsetX
                currentRowMaxItemHeight = 0
                lastHeaderAttributeSize = CGSize.zero
                lastFooterAttributeSize = CGSize.zero
                
                attributeDict = [FLIdentifierType.Header : [headerAttribute], FLIdentifierType.Cell : itemAttributes, FLIdentifierType.Footer : [footerAttribute]]
                
            }
            sectionAttributes.append(attributeDict)
        }
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if flowLayoutStyle == .System {
            return super.layoutAttributesForItem(at: indexPath)
        }
        guard let attributeDict = sectionAttributes[indexPath.section] else {
            return nil
        }
        guard let itemAttributes : LayoutAttributesArray = attributeDict[FLIdentifierType.Cell] else {
            return nil
        }
        return itemAttributes?[indexPath.item]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if flowLayoutStyle == .System {
            return super.layoutAttributesForSupplementaryView(ofKind: elementKind, at:indexPath)
        }
        guard let attributeDict = sectionAttributes[indexPath.section] else {
            return nil
        }
        if elementKind == UICollectionElementKindSectionHeader {
            guard let headerAttributes : LayoutAttributesArray = attributeDict[FLIdentifierType.Header] else {
                return nil
            }
            return headerAttributes?.first
        }
        else {
            guard let footerAttributes : LayoutAttributesArray = attributeDict[FLIdentifierType.Footer] else {
                return nil
            }
            return footerAttributes?.first
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if flowLayoutStyle == .System {
            return super.layoutAttributesForElements(in: rect)
        }
        var totalAttributes : LayoutAttributesArray = []
        for attributeDict in sectionAttributes {
            if let attributeDict = attributeDict {
                if let headerAttributes : LayoutAttributesArray = attributeDict[FLIdentifierType.Header] {
                    totalAttributes = totalAttributes! + headerAttributes!
                }
                if let itemAttributes : LayoutAttributesArray = attributeDict[FLIdentifierType.Cell] {
                    totalAttributes = totalAttributes! + itemAttributes!
                }
                if let footerAttributes : LayoutAttributesArray = attributeDict[FLIdentifierType.Footer] {
                    totalAttributes = totalAttributes! + footerAttributes!
                }
            }
        }
        
        return totalAttributes?.filter({ (attribute) -> Bool in
            return CGRect.intersects(rect)(attribute.frame)
        })
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if flowLayoutStyle == .System {
            return super.shouldInvalidateLayout(forBoundsChange: newBounds)
        }
        return false
    }
    
    
    override var collectionViewContentSize: CGSize {
        if flowLayoutStyle == .System {
            return super.collectionViewContentSize
        }
        
        if verticalTotalItemMaxY == 0 {
            return CGSize.zero
        }
        
        return CGSize.init(width: (self.collectionView?.frame.size.width)!, height: verticalTotalItemMaxY)
        
    }
    
}
