//
//  FLBaseComponent.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

let FLHeaderFooterTitleTopPadding : CGFloat = 5
let FLHeaderFooterTitleLeftPadding : CGFloat = 20

class FLBaseComponent: NSObject, FLTableComponentConfiguration {
    
    var tableView : UITableView?
    
    weak var delegate : FLTableComponentEvent?
    
    init(tableView : UITableView){
        super.init()
        self.tableView = tableView
        // regist cell
        self.register()
    }
}

// MARK : base configuration

extension FLBaseComponent {
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
        tableView?.registerClass(className: FLTableViewHeaderFooterView.self, headerFooterViewReuseIdentifier: self.headerIdentifier)
        tableView?.registerClass(className: FLTableViewHeaderFooterView.self, headerFooterViewReuseIdentifier: self.footerIdentifier)
    }
    
    func numberOfRows() -> NSInteger {
        return 0
    }
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        return (tableView?.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath))!
    }
}

// MARK : header or footer customizaion

extension FLBaseComponent {
    func headerView(at section: Int) -> FLTableViewHeaderFooterView? {
        let headerView = tableView?.dequeueReusableFLHeaderFooterView(withIdentifier: self.headerIdentifier)
        if let headerTitle = self.titleForHeader(at: section) {
            headerView?.titleLabel.attributedText = headerTitle
        }
        headerView?.delegate = delegate
        headerView?.section = section
        headerView?.headerFooterType = .Header
        return headerView
    }
    
    func footerView(at section: Int) -> FLTableViewHeaderFooterView? {
        let footerView = tableView?.dequeueReusableFLHeaderFooterView(withIdentifier: self.footerIdentifier)
        if let footerTitle = self.titleForFooter(at: section) {
            footerView?.titleLabel.attributedText = footerTitle
        }
        footerView?.delegate = delegate
        footerView?.section = section
        footerView?.headerFooterType = .Footer
        return footerView
    }
    
    func heightForHeader(at section : Int) -> CGFloat {
        if let headerTitle = self.titleForHeader(at: section) {
            return suitableTitleHeight(forString: headerTitle)
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func heightForFooter(at section : Int) -> CGFloat {
        if let footerTitle = self.titleForFooter(at: section) {
            return suitableTitleHeight(forString: footerTitle)
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func titleForHeader(at section : Int) -> NSMutableAttributedString? {
        return nil
    }
    
    func titleForFooter(at section : Int) -> NSMutableAttributedString? {
        return nil
    }
    
    private func suitableTitleHeight(forString string : NSMutableAttributedString) -> CGFloat{
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect = string.boundingRect(with: CGSize.init(width: UIScreen.main.bounds.width - 2 * FLHeaderFooterTitleLeftPadding, height: CGFloat.greatestFiniteMagnitude), options: option, context: nil)
        // footer or header height must higher than the real rect for footer or header title,otherwise, footer or header title will offset
        return rect.height + FLHeaderFooterTitleTopPadding * 2
    }
}

// MARK : Display customization

extension FLBaseComponent {
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
    
    func dequeueReusableFLHeaderFooterView(withIdentifier identifier: String) -> FLTableViewHeaderFooterView?{
        return self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? FLTableViewHeaderFooterView
    }
}

extension NSMutableAttributedString {
    
}

