//
//  NibDemoComponent.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class NibDemoComponent: FLTableBaseComponent {
    
    override func register() {
        // MARK : Do not call super register, if you just want to reuse headerView, otherwise, you should call super
//        super.register()
        
        self.tableView?.registerNib(className: NibDemoTableViewCell.self, cellReuseIdentifier: self.cellIdentifier)
    }
    
    override func cellForRow(at row: Int) -> UITableViewCell {
        let cell : NibDemoTableViewCell = super.cellForRow(at: row) as! NibDemoTableViewCell
        return cell
    }
    
    override func numberOfRows() -> NSInteger {
        return 3
    }
    
    override func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func headerView(at section: Int) -> FLTableViewHeaderFooterView? {
        // reuse slider too
        let headerView = super.headerView(at: section)
        headerView?.contentView.backgroundColor = UIColor.yellow
        return headerView
    }
    
    override func additionalOperationForReuseHeaderView(_ headerView: FLTableViewHeaderFooterView?) {
        headerView?.addSubview(UISlider.init(frame: CGRect.init(x: 20, y: 0, width: 100, height: 30)))
        let btn = UIButton.init(type: UIButtonType.contactAdd)
        btn.frame = CGRect.init(x: 200, y: 0, width: 30, height: 30)
        headerView?.addSubview(btn)
    }
    
    override func heightForHeader(at section: Int) -> CGFloat {
        return 30
    }
    
    override func footerView(at section: Int) -> FLTableViewHeaderFooterView? {
        // reuse slider too
        let footerView = super.footerView(at: section)
        footerView?.contentView.backgroundColor = UIColor.purple
        return footerView
    }
    
    override func additionalOperationForReuseFooterView(_ footerView: FLTableViewHeaderFooterView?) {
        // the same as header
    }
    
    override func heightForFooter(at section: Int) -> CGFloat {
        return 10
    }
    
}
