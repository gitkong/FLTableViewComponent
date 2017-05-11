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
    
//    @objc optional var customTableView : UITableView { get }
    @objc optional var tableViewStyle : UITableViewStyle { get }
    @objc optional func customRect() -> CGRect
    
    @objc optional var cellIdentifier : String { get }
    @objc optional var headerIdentifier : String { get }
    @objc optional var footerIdentifier : String { get }
    
    // normal configuration
    
    @objc optional func register()
    
    @objc optional func numberOfRows() -> NSInteger
    @objc optional func cellForRow(at indexPath: IndexPath) -> UITableViewCell
    
    // header or footer customizaion
    
    @objc optional func headerView(at section: Int) -> UITableViewHeaderFooterView?
    
    @objc optional func footerView(at section: Int) -> UITableViewHeaderFooterView?
    
    // Display customization
    
    @objc optional func tableView(willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    @objc optional func tableView(didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    @objc optional func tableView(willDisplayHeaderView view: UITableViewHeaderFooterView, forSection section: Int)
    
    @objc optional func tableView(willDisplayFooterView view: UITableViewHeaderFooterView, forSection section: Int)
    
    @objc optional func tableView(didEndDisplayingHeaderView view: UITableViewHeaderFooterView, forSection section: Int)
    
    @objc optional func tableView(didEndDisplayingFooterView view: UITableViewHeaderFooterView, forSection section: Int)
}

protocol FLTableComponentEvent {
    
}
