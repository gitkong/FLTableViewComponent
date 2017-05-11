//
//  FLBaseComponent.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class FLBaseComponent: NSObject {
    
    var tableView : UITableView?
    
    init(tableView : UITableView){
        super.init()
        self.tableView = tableView
        // regist cell
        self.register()
    }
}

extension FLBaseComponent : FLTableComponentConfiguration{
    var cellIdentifier : String {
        return "\(NSStringFromClass(type(of: self)))-cell"
    }
    
    var footerIdentifier: String {
        return "\(NSStringFromClass(type(of: self)))-footer"
    }
    
    var headerIdentifier: String {
        return "\(NSStringFromClass(type(of: self)))-header"
    }
    
    func register() {
        tableView?.registerClass(className: UITableViewCell.self, cellReuseIdentifier: self.cellIdentifier)
        tableView?.registerClass(className: UITableViewHeaderFooterView.self, headerFooterViewReuseIdentifier: self.headerIdentifier)
        tableView?.registerClass(className: UITableViewHeaderFooterView.self, headerFooterViewReuseIdentifier: self.footerIdentifier)
    }
    
    func numberOfRows() -> NSInteger {
        return 0
    }
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        return (tableView?.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath))!
    }
    
    // header or footer customizaion
    
    func headerView(at section: Int) -> UITableViewHeaderFooterView?{
        return tableView?.dequeueReusableHeaderFooterView(withIdentifier: self.headerIdentifier)
    }
    
    func footerView(at section: Int) -> UITableViewHeaderFooterView?{
        return tableView?.dequeueReusableHeaderFooterView(withIdentifier: self.footerIdentifier)
    }
    
    // Display customization
    
    func tableView(willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        // do nothing
    }
    
    func tableView(willDisplayHeaderView view: UITableViewHeaderFooterView, forSection section: Int){
        
    }
    
    func tableView(willDisplayFooterView view: UITableViewHeaderFooterView, forSection section: Int){
        
    }
    
    func tableView(didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
    }
    
    func tableView(didEndDisplayingHeaderView view: UITableViewHeaderFooterView, forSection section: Int){
        
    }
    
    func tableView(didEndDisplayingFooterView view: UITableViewHeaderFooterView, forSection section: Int){
        
    }
}

extension UITableView{
    func registerNib(className : AnyClass, cellReuseIdentifier : String){

        if let name = NSStringFromClass(className).components(separatedBy: ".").last {
            self.register(UINib.init(nibName: name, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        }
        else{
            print("registerNib \(className) failure")
        }
    }
    
    func registerClass(className : AnyClass, cellReuseIdentifier : String){
        
        self.register(className, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    
    func registerNib(className : AnyClass, headerFooterViewReuseIdentifier : String){
        
        if let name = NSStringFromClass(className).components(separatedBy: ".").last {
            self.register(UINib.init(nibName: name, bundle: nil), forHeaderFooterViewReuseIdentifier: headerFooterViewReuseIdentifier)
        }
        else{
            print("registerNib \(className) failure")
        }
    }
    
    func registerClass(className : AnyClass, headerFooterViewReuseIdentifier : String){
        
        self.register(className, forHeaderFooterViewReuseIdentifier: headerFooterViewReuseIdentifier)
    }
}

