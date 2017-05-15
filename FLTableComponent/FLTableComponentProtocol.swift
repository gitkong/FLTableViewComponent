//
//  FLTableComponentConfiguration.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

@objc protocol FLTableComponentConfiguration {
    
    // custom UI,default tableView is plain and rect is self.view.bounds
    
    @objc optional var tableViewStyle : UITableViewStyle { get }
    
    @objc optional func customRect() -> CGRect
    
    @objc optional var cellIdentifier : String { get }
    
    @objc optional var headerIdentifier : String { get }
    
    @objc optional var footerIdentifier : String { get }
    
    // normal configuration
    
    // MARK : Do not call super register, if you just want to reuse headerView, otherwise, you should call super.register()
    @objc optional func register()
    
    @objc optional func numberOfRows() -> NSInteger
    
    @objc optional func cellForRow(at indexPath: IndexPath) -> UITableViewCell
    
    // header or footer customizaion
    
    @objc optional func headerView(at section: Int) -> FLTableViewHeaderFooterView?
    
    @objc optional func footerView(at section: Int) -> FLTableViewHeaderFooterView?
    
    @objc optional func titleForHeader(at section : Int) -> NSMutableAttributedString?
    
    @objc optional func titleForFooter(at section : Int) -> NSMutableAttributedString?
    
    // height customization
    
    @objc optional func heightForRow(at indexPath: IndexPath) -> CGFloat
    
    @objc optional func heightForHeader(at section : Int) -> CGFloat
    
    @objc optional func heightForFooter(at section : Int) -> CGFloat
    
    // Display customization
    
    @objc optional func tableView(willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    @objc optional func tableView(didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    @objc optional func tableView(willDisplayHeaderView view: FLTableViewHeaderFooterView, forSection section: Int)
    
    @objc optional func tableView(willDisplayFooterView view: FLTableViewHeaderFooterView, forSection section: Int)
    
    @objc optional func tableView(didEndDisplayingHeaderView view: FLTableViewHeaderFooterView, forSection section: Int)
    
    @objc optional func tableView(didEndDisplayingFooterView view: FLTableViewHeaderFooterView, forSection section: Int)
}

@objc protocol FLTableComponentEvent {
    
    // Header or Footer tapping event
    
    @objc optional func tableHeaderView(_  headerView : FLTableViewHeaderFooterView, didClickSectionAt section: Int)
    
    @objc optional func tableFooterView(_  footerView : FLTableViewHeaderFooterView, didClickSectionAt section: Int)
    
}