//
//  NibDemoComponent.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class NibDemoComponent: FLBaseComponent {
    
    override func register() {
        // MARK : Do not call super register, if you just want to reuse headerView, otherwise, you should call super
//        super.register()
        
        self.tableView?.registerNib(className: NibDemoTableViewCell.self, cellReuseIdentifier: self.cellIdentifier)
    }
    
    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        let cell : NibDemoTableViewCell = super.cellForRow(at: indexPath) as! NibDemoTableViewCell
        return cell
    }
    
    override func numberOfRows() -> NSInteger {
        return 3
    }
    
    override func headerView(at section: Int) -> FLTableViewHeaderFooterView? {
        // reuse slider too
        var headerView = super.headerView(at: section)
        if (headerView == nil) {
            // MARK : if you want header or footer view have accurate event handling capabilities, you should initialize with init(reuseIdentifier: String?, section: Int)
            headerView = FLTableViewHeaderFooterView.init(reuseIdentifier: self.headerIdentifier,section: section)
            headerView?.addSubview(UISlider.init(frame: CGRect.init(x: 20, y: 0, width: 100, height: 30)))
        }
        headerView?.contentView.backgroundColor = UIColor.yellow
        return headerView
    }
    
    override func heightForHeader(at section: Int) -> CGFloat {
        return 30
    }
}
