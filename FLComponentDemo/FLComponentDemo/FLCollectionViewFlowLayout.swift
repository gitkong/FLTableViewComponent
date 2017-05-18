//
//  FLCollectionViewFlowLayout.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/18.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

typealias LayoutAttributesArray = Array<UICollectionViewLayoutAttributes>

typealias LayoutAttributesDict = Dictionary<FLIdentifierType , LayoutAttributesArray>

@objc enum FLCollectionViewFlowLayoutStyle : NSInteger{
    case System = 0// Both ends of the same spacing, the middle spacing is not equal, alignment is center
    case Custom = 1// Both ends of spacing is not equal, the middle spacing is equal, alignment is top
}

class FLCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    weak var delegate : UICollectionViewDelegateFlowLayout?
    
    private var sectionAttributes : Array<LayoutAttributesDict> = []
    
    private var flowLayoutStyle : FLCollectionViewFlowLayoutStyle = .System
    
    convenience init(with flowLayoutStyle : FLCollectionViewFlowLayoutStyle = .System) {
        self.init()
        self.flowLayoutStyle = flowLayoutStyle
    }
    
    override init() {
        super.init()
        self.scrollDirection = .vertical
        self.minimumInteritemSpacing = 8
        self.minimumLineSpacing = 8
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        if flowLayoutStyle == .System {
            return
        }
        guard self.collectionView != nil , let sections = self.collectionView?.numberOfSections else {
            return
        }
        
        sectionAttributes.removeAll()
        
        var offsetX : CGFloat = self.sectionInset.left
        var nextOffsetX : CGFloat = self.sectionInset.left
        var offsetY : CGFloat = self.sectionInset.top
        var verticalTotalItemHeight : CGFloat = 0
        var currentRowMaxItemHeight : CGFloat = 0
        var lastHeaderAttributeHeight : CGFloat = 0
        for section in 0 ..< sections {
            
            var itemAttributes : LayoutAttributesArray = []
            var attributeDict : LayoutAttributesDict = [FLIdentifierType.Cell : itemAttributes]
            if let items = self.collectionView?.numberOfItems(inSection: section) {

                let headerAttribute = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: IndexPath.init(item: 0, section: section))
                headerAttribute.frame = CGRect.init(origin: CGPoint.init(x: 0, y: verticalTotalItemHeight), size: (self.delegate?.collectionView!(self.collectionView!, layout: self, referenceSizeForHeaderInSection: section))!)
                
                print("----- section (\(section))  ------")
                
                for item in 0 ..< items {
                    let indexPath = IndexPath.init(item: item, section: section)
                    
                    let attribute = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                    if let itemSize = self.delegate?.collectionView!(self.collectionView!, layout: self, sizeForItemAt: indexPath) {
                        
                        print("compare : \(currentRowMaxItemHeight)  -  \(itemSize.height)")
                        currentRowMaxItemHeight = max(currentRowMaxItemHeight, itemSize.height)
                        
                        nextOffsetX = nextOffsetX + self.minimumInteritemSpacing + itemSize.width
                        
                        if nextOffsetX > self.collectionView!.bounds.size.width - self.sectionInset.right {
                            
                            offsetX = self.sectionInset.left
                            nextOffsetX = self.sectionInset.left + self.minimumInteritemSpacing + itemSize.width
                            offsetY = offsetY + currentRowMaxItemHeight + self.minimumLineSpacing
                            print("max item height = \(currentRowMaxItemHeight)")
                            // next row , compare with last itemSize
                            currentRowMaxItemHeight = itemSize.height
                        }
                        else {
                            offsetX = nextOffsetX - (self.minimumInteritemSpacing + itemSize.width)
                        }
                        
                        attribute.frame = CGRect.init(x: offsetX, y: offsetY + headerAttribute.frame.size.height, width: itemSize.width, height: itemSize.height)
                        
                        
                        if item == items - 1 {
                            verticalTotalItemHeight = currentRowMaxItemHeight + attribute.frame.origin.y + self.minimumLineSpacing
                            lastHeaderAttributeHeight = headerAttribute.frame.size.height
                        }
                    }
                    itemAttributes.append(attribute)
                }
                
                // reset
                
                offsetX = self.sectionInset.left
                nextOffsetX = offsetX
                offsetY = verticalTotalItemHeight - lastHeaderAttributeHeight + headerAttribute.frame.size.height + self.minimumLineSpacing
                
                currentRowMaxItemHeight = 0
                lastHeaderAttributeHeight = 0
                
                attributeDict = [FLIdentifierType.Header : [headerAttribute], FLIdentifierType.Cell : itemAttributes]
            }
            sectionAttributes.append(attributeDict)
        }
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if flowLayoutStyle == .System {
            return super.layoutAttributesForItem(at: indexPath)
        }
        let attributeDict = sectionAttributes[indexPath.section]
        let itemAttributes : LayoutAttributesArray = attributeDict[FLIdentifierType.Cell]!
        return itemAttributes[indexPath.item]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if flowLayoutStyle == .System {
            return super.layoutAttributesForSupplementaryView(ofKind: elementKind, at:indexPath)
        }
        let attributeDict = sectionAttributes[indexPath.section]
        let headerAttributes : LayoutAttributesArray = attributeDict[FLIdentifierType.Header]!
        return headerAttributes.first
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if flowLayoutStyle == .System {
            return super.layoutAttributesForElements(in: rect)
        }
        var totalAttributes : LayoutAttributesArray = []
        for attributeDict in sectionAttributes {
            let headerAttributes : LayoutAttributesArray = attributeDict[FLIdentifierType.Header]!
            let itemAttributes : LayoutAttributesArray = attributeDict[FLIdentifierType.Cell]!
            totalAttributes = totalAttributes + headerAttributes + itemAttributes
        }
        
        return totalAttributes.filter({ (attribute) -> Bool in
            return CGRect.intersects(rect)(attribute.frame)
        })
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if flowLayoutStyle == .System {
            return super.shouldInvalidateLayout(forBoundsChange: newBounds)
        }
        return false
    }
    
}
