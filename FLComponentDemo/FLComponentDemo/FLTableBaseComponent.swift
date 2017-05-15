//
//  FLTableBaseComponent.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

let FLHeaderFooterTitleTopPadding : CGFloat = 5
let FLHeaderFooterTitleLeftPadding : CGFloat = 20
let FLTableViewCellDefaultHeight : CGFloat = 44

enum FLIdentifierType  : String{
    case Cell = "cell"
    case Header = "header"
    case Footer = "footer"
    
    static func type(of  reuseIdentifier : String?) -> FLIdentifierType? {
        if let reuseId = reuseIdentifier {
            if reuseId.hasSuffix(FLIdentifierType.Header.rawValue) {
                return .Header
            }
            else if reuseId.hasSuffix(FLIdentifierType.Footer.rawValue) {
                return .Footer
            }
            else {
                return .Cell
            }
        }
        return nil
    }
}

class FLTableBaseComponent: NSObject, FLTableComponentConfiguration {
    
    var tableView : UITableView?
    
    weak var componentController : FLTableComponentEvent?
    
    init(tableView : UITableView){
        super.init()
        self.tableView = tableView
        // regist cell or header or footer
        self.register()
    }
}

// MARK : base configuration

extension FLTableBaseComponent {
    final var cellIdentifier : String {
        return "\(NSStringFromClass(type(of: self))).\(FLIdentifierType.Cell.rawValue)"
    }
    
    final var footerIdentifier: String {
        return "\(NSStringFromClass(type(of: self))).\(FLIdentifierType.Footer.rawValue)"
    }
    
    final var headerIdentifier: String {
        return "\(NSStringFromClass(type(of: self))).\(FLIdentifierType.Header.rawValue)"
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

extension FLTableBaseComponent {
    
    
    /// you can override this method to perform additional operation, such as add lable or button into headerView to resue, but if you had registed the class of FLTableViewHeaderFooterView for headerView, this method will be invalid, so if you want it to be valiable, do not call super when you override register() method
    ///
    /// - Parameter headerView:  headerView for ready to reuse
    func additionalOperationForReuseHeaderView(_ headerView : FLTableViewHeaderFooterView?) {
        // do something , such as add lable or button into headerView or footerView to resue
    }
    
    
    /// you can override this method to perform additional operation, such as add lable or button into footerView to resue, but if you had registed the class of FLTableViewHeaderFooterView for footerView, this method will be invalid, so if you want it to be valiable, do not call super when you override register() method
    ///
    /// - Parameter footerView: footerView for ready to reuse
    func additionalOperationForReuseFooterView(_ footerView : FLTableViewHeaderFooterView?) {
        
    }
    
    
    /// when you override this method, you should call super to get headerView if you just regist the class of FLTableViewHeaderFooterView; if you override the method of register() to regist the subclass of FLTableViewHeaderFooterView, you can not call super to get headerView, and you should call init(reuseIdentifier: String?, section: Int) and addClickDelegete(for headerFooterView : FLTableViewHeaderFooterView?)  if this headerView have to accurate tapping event
    ///
    /// - Parameter section: current section
    /// - Returns: FLTableViewHeaderFooterView
    func headerView(at section: Int) -> FLTableViewHeaderFooterView? {
        var headerView = tableView?.dequeueReusableFLHeaderFooterView(withIdentifier: self.headerIdentifier)
        // MARK : if subclass override headerView(at section: Int) method , also override register() and do nothing in it, so headerView will be nil, then create the new one to reuse it
        if (headerView == nil) {
            // MARK : if you want header or footer view have accurate event handling capabilities, you should initialize with init(reuseIdentifier: String?, section: Int)
            headerView = FLTableViewHeaderFooterView.init(reuseIdentifier: self.headerIdentifier,section: section)
            additionalOperationForReuseHeaderView(headerView)
        }
        if let headerTitle = self.titleForHeader(at: section) {
            headerView?.titleLabel.attributedText = headerTitle
        }
        addClickDelegete(for: headerView)
        headerView?.section = section
        return headerView
    }
    
    /// when you override this method, you should call super to get footerView if you just regist the class of FLTableViewHeaderFooterView; if you override the method of register() to regist the subclass of FLTableViewHeaderFooterView, you can not call super to get headerView, and you should call init(reuseIdentifier: String?, section: Int) and addClickDelegete(for headerFooterView : FLTableViewHeaderFooterView?)  if this footerView have to accurate tapping event
    ///
    /// - Parameter section: current section
    /// - Returns: FLTableViewHeaderFooterView
    func footerView(at section: Int) -> FLTableViewHeaderFooterView? {
        var footerView = tableView?.dequeueReusableFLHeaderFooterView(withIdentifier: self.footerIdentifier)
        if (footerView == nil) {
            // MARK : if you want header or footer view have accurate event handling capabilities, you should initialize with init(reuseIdentifier: String?, section: Int)
            footerView = FLTableViewHeaderFooterView.init(reuseIdentifier: self.footerIdentifier,section: section)
            additionalOperationForReuseFooterView(footerView)
        }
        if let footerTitle = self.titleForFooter(at: section) {
            footerView?.titleLabel.attributedText = footerTitle
        }
        addClickDelegete(for: footerView)
        footerView?.section = section
        return footerView
    }
    
    func titleForHeader(at section : Int) -> NSMutableAttributedString? {
        return nil
    }
    
    func titleForFooter(at section : Int) -> NSMutableAttributedString? {
        return nil
    }
    
    private func addClickDelegete(for headerFooterView : FLTableViewHeaderFooterView?)  {
        headerFooterView?.delegate = componentController
    }
}

// MARK : height customization

extension FLTableBaseComponent {
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return FLTableViewCellDefaultHeight
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
    
    private func suitableTitleHeight(forString string : NSMutableAttributedString) -> CGFloat{
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect = string.boundingRect(with: CGSize.init(width: UIScreen.main.bounds.width - 2 * FLHeaderFooterTitleLeftPadding, height: CGFloat.greatestFiniteMagnitude), options: option, context: nil)
        // footer or header height must higher than the real rect for footer or header title,otherwise, footer or header title will offset
        return rect.height + FLHeaderFooterTitleTopPadding * 2
    }
}

// MARK : Display customization

extension FLTableBaseComponent {
    func tableView(willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        // do nothing
    }
    
    func tableView(didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
    }
    
    func tableView(willDisplayHeaderView view: FLTableViewHeaderFooterView, forSection section: Int){
        
    }
    
    func tableView(willDisplayFooterView view: FLTableViewHeaderFooterView, forSection section: Int){
        
    }
    
    func tableView(didEndDisplayingHeaderView view: FLTableViewHeaderFooterView, forSection section: Int){
        
    }
    
    func tableView(didEndDisplayingFooterView view: FLTableViewHeaderFooterView, forSection section: Int){
        
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

