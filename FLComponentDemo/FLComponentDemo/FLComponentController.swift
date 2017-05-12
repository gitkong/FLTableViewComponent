//
//  FLComponentController.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class FLComponentController: UIViewController {
    
    lazy var tableView : UITableView = {
        let tableView : UITableView = UITableView.init(frame: self.customRect(), style: self.tableViewStyle)
        tableView.frame = self.customRect()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var components : Array<FLTableComponentConfiguration> = [] {
        didSet{
            if components.count != 0 {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.customRect()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(self.tableView)
    }
}

extension FLComponentController : FLTableComponentConfiguration,UITableViewDelegate, UITableViewDataSource{
    
    var tableViewStyle: UITableViewStyle {
        return UITableViewStyle.plain
    }
    
    func customRect() -> CGRect {
        return self.view.bounds
    }
}

// MARK : tableView datasource

extension FLComponentController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components[section].numberOfRows!()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return components[indexPath.section].cellForRow!(at: indexPath)
    }
}

// MARK : header or footer customizaion

extension FLComponentController {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        return components[section].headerView!(at: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        return components[section].footerView!(at: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return components[section].heightForHeader!(at: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return components[section].heightForFooter!(at: section)
    }
}

// MARK : Display customization

extension FLComponentController {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        components[indexPath.section].tableView!(willDisplay: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        components[section].tableView!(willDisplayHeaderView: (view as? UITableViewHeaderFooterView)!, forSection: section)
    }
    
    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int){
        components[section].tableView!(willDisplayFooterView: (view as? UITableViewHeaderFooterView)!, forSection: section)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int){
        components[section].tableView!(didEndDisplayingHeaderView: (view as? UITableViewHeaderFooterView)!, forSection: section)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int){
        components[section].tableView!(didEndDisplayingFooterView: (view as? UITableViewHeaderFooterView)!, forSection: section)
    }
}

// MARK : selection

extension FLComponentController {
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
//    
//    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//        
//    }
//    
//    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
//        
//    }
    
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        
//    }
//    
//    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
//        
//    }
    
    // Called after the user changes the selection.
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let component = components[indexPath.section]
//        component.
//        component.
//        components[indexPath.section].tableView!(didSelectRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}



