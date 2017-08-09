//
//  FLBaseComponentProtocol.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

// MARK : this protocol methods must be implemented

@objc protocol FLBaseComponentProtocol {
    
    @objc optional var customRect : CGRect { get }
    
    @objc optional var cellIdentifier : String { get }
    
    @objc optional var headerIdentifier : String { get }
    
    @objc optional var footerIdentifier : String { get }
    
    // MARK : Do not call super register, if you just want to reuse headerView, otherwise, you should call super.register()
    @objc optional func register()
    
    @objc optional func reloadComponent()
    
    @objc optional func reloadSelfComponent()
    
}
