//
//  FLTableComponentController.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class FLTableComponentController: UIViewController {
    
    lazy var tableView : UITableView = {
        let tableView : UITableView = UITableView.init(frame: self.customRect, style: self.tableViewStyle)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var components : Array<FLTableBaseComponent> = []
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = self.customRect
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
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

extension FLTableComponentController : FLTableComponentConfiguration,UITableViewDelegate, UITableViewDataSource{
    
    var tableViewStyle: UITableViewStyle {
        return UITableViewStyle.plain
    }
    
    var customRect: CGRect {
        return self.view.bounds
    }
    
    func reloadComponent() {
        self.tableView.reloadData()
    }
}

// MARK : tableView datasource

extension FLTableComponentController {
    
    final func numberOfSections(in tableView: UITableView) -> Int {
        return components.count
    }
    
    final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard components.count > 0 else {
            return 0
        }
        return components[section].numberOfRows()
    }
    
    final func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard components.count > 0 else {
            return UITableViewCell()
        }
        let component : FLTableBaseComponent = components[indexPath.section]
        component.section = indexPath.section
        return component.cellForRow(at: indexPath.row)
    }
}

// MARK : header or footer customizaion

extension FLTableComponentController {
    
    final func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        guard components.count > 0 else {
            return nil
        }
        let component = components[section]
        component.componentController = self
        return component.headerView()
    }
    
    final func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        guard components.count > 0 else {
            return nil
        }
        let component = components[section]
        component.componentController = self
        return component.footerView()
    }
}

// MARK : Hight customization

extension FLTableComponentController {
    
    final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        guard components.count > 0 else {
            return 0
        }
        return components[indexPath.section].heightForRow(at: indexPath.row)
    }
    
    final func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        guard components.count > 0 else {
            return 0
        }
        return components[section].heightForHeader()
    }
    
    final func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        guard components.count > 0 else {
            return 0
        }
        return components[section].heightForFooter()
    }
    
}

// MARK : Display customization

extension FLTableComponentController {
    
    final func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        guard components.count > 0 else {
            return
        }
        components[indexPath.section].tableView(willDisplayCell: cell, at: indexPath.row)
    }
    
    final public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath){
        guard components.count > 0 else {
            return
        }
        components[indexPath.section].tableView(didEndDisplayCell: cell, at: indexPath.row)
    }
    
    final public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        guard components.count > 0 else {
            return
        }
        components[section].tableView(willDisplayHeaderView: (view as? FLTableViewHeaderFooterView)!)
    }
    
    final public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int){
        guard components.count > 0 else {
            return
        }
        components[section].tableView(willDisplayFooterView: (view as? FLTableViewHeaderFooterView)!)
    }
    
    final public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int){
        guard components.count > 0 else {
            return
        }
        components[section].tableView(didEndDisplayHeaderView: (view as? FLTableViewHeaderFooterView)!)
    }
    
    final public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int){
        guard components.count > 0 else {
            return
        }
        components[section].tableView(didEndDisplayFooterView: (view as? FLTableViewHeaderFooterView)!)
    }
}

// MARK : selection

extension FLTableComponentController : FLTableComponentEvent{
    
    func tableHeaderView(_  headerView : FLTableViewHeaderFooterView, didClickSectionAt section: Int){
        // do nothing
    }
    
    func tableFooterView(_  footerView : FLTableViewHeaderFooterView, didClickSectionAt section: Int){
        
    }
    
}



