//
//  DemoComponent.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoComponent: FLTableBaseComponent {
    
    override func register() {
//        super.register()
    }
    
    override func cellForRow(at row: Int) -> UITableViewCell {
        let cell : UITableViewCell = super.cellForRow(at: row)
        return cell
    }
    
    override func additionalOperationForReuseCell(_ cell: UITableViewCell?) {
        let switchView : UISwitch = UISwitch.init(frame: CGRect.init(x: 200, y: 0, width: 60, height: 30))
        cell?.addSubview(switchView)
    }
    
    override func numberOfRows() -> NSInteger {
        return 2
    }
    
    override func tableView(willDisplayCell cell: UITableViewCell, at row: Int) {
        cell.textLabel?.text = "gitKong"
    }
    
    override func titleForHeader() -> NSMutableAttributedString? {
        let attStr = NSMutableAttributedString.init(string: "hello world,hello gitKong, i am header title test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test")
        // must add attribute,otherwise,calculate the wrong rect for attribute string
        attStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 17), range: NSRange.init(location: 0, length: attStr.length))
        attStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 13), range: NSRange.init(location: 5, length: 10))
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange.init(location: 0, length: 5))
        return attStr
    }
    
    override func footerView() -> FLTableViewHeaderFooterView? {
        // just resue footerView,so call super.register()
        let footerView = super.footerView()
        footerView?.contentView.backgroundColor = UIColor.red
        return footerView
    }
    
    override func heightForFooter() -> CGFloat {
        return 20
    }
    
    
}
