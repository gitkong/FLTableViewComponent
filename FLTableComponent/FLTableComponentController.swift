//
//  FLTableComponentController.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class FLTableComponentController: UIViewController {
    
    private(set) var handler : FLTableViewHandler = FLTableViewHandler()
    
    lazy var tableView : UITableView = {
        let tableView : UITableView = UITableView.init(frame: self.customRect, style: self.tableViewStyle)
        return tableView
    }()
    
    var components : Array<FLTableBaseComponent> = [] {
        didSet {
            handler.components = components
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = self.customRect
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        handler.delegate = self
        view.addSubview(tableView)
        
        self.tableView.tableHeaderView = headerView(of: tableView)
        self.tableView.tableFooterView = footerView(of: tableView)
    }
    
    func headerView(of tableView : UITableView) -> UIView? {
        return nil
    }
    
    func footerView(of tableView : UITableView) -> UIView? {
        return nil
    }
}

extension FLTableComponentController : FLTableComponentConfiguration {
    
    var tableViewStyle: UITableViewStyle {
        return UITableViewStyle.plain
    }
    
    var customRect: CGRect {
        return self.view.bounds
    }
    
    func reloadComponent() {
        handler.reloadComponents()
    }
}

extension FLTableComponentController : FLTableViewHandlerDelegate {
    
    func tableViewDidClick(_ handler: FLTableViewHandler, cellAt indexPath: IndexPath) {
        // subclass override it
    }
    
    func tableViewDidClick(_ handler: FLTableViewHandler, headerAt section: NSInteger) {
        // subclass override it
    }
    
    func tableViewDidClick(_ handler: FLTableViewHandler, footerAt section: NSInteger) {
        // subclass override it
    }
}




