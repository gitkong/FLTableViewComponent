//
//  FLBaseHandlerProtocol.swift
//  FLComponentDemo
//
//  Created by 孔凡列 on 2017/7/29.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

// MARK : modifily components

protocol FLTableViewHandlerProtocol {
    
    func component(by identifier: String) -> FLTableBaseComponent?
    func component(at index : NSInteger) -> FLTableBaseComponent?
    
    func exchange(_ component : FLTableBaseComponent, by exchangeComponent : FLTableBaseComponent)
    
    func replace(_ component : FLTableBaseComponent, by replacementComponent : FLTableBaseComponent)
    
    func addAfterIdentifier(_ component : FLTableBaseComponent, after identifier : String)
    func addAfterComponent(_ component : FLTableBaseComponent, after afterComponent : FLTableBaseComponent)
    func addAfterSection(_ component : FLTableBaseComponent, after index : NSInteger)
    func add(_ component : FLTableBaseComponent)
    
    func removeComponent(by identifier : String, removeType : FLComponentRemoveType)
    func removeComponent(_ component : FLTableBaseComponent?)
    func removeComponent(at index : NSInteger)

    func reloadComponents()
    func reloadComponents(_ components : [FLTableBaseComponent])
    func reloadComponent(_ component : FLTableBaseComponent)
    func reloadComponent(at index : NSInteger)
    
}

protocol FLCollectionViewHandlerProtocol {
    
    func component(by identifier: String) -> FLCollectionBaseComponent?
    func component(at index : NSInteger) -> FLCollectionBaseComponent?
    
    func exchange(_ component : FLCollectionBaseComponent, by exchangeComponent : FLCollectionBaseComponent)
    
    func replace(_ component : FLCollectionBaseComponent, by replacementComponent : FLCollectionBaseComponent)
    
    func addAfterIdentifier(_ component : FLCollectionBaseComponent, after identifier : String)
    func addAfterComponent(_ component : FLCollectionBaseComponent, after afterComponent : FLCollectionBaseComponent)
    func addAfterSection(_ component : FLCollectionBaseComponent, after index : NSInteger)
    func add(_ component : FLCollectionBaseComponent)
    
    func removeComponent(by identifier : String, removeType : FLComponentRemoveType)
    func removeComponent(_ component : FLCollectionBaseComponent?)
    func removeComponent(at index : NSInteger)
    
    func reloadComponents()
    func reloadComponents(_ components : [FLCollectionBaseComponent])
    func reloadComponent(_ component : FLCollectionBaseComponent)
    func reloadComponent(at index : NSInteger)
    
}
