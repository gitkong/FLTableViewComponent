//
//  DemoComponent.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoComponent: FLBaseComponent {
    
    override func register() {
        super.register()
    }
    
    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = super.cellForRow(at: indexPath)
        return cell
    }
    
    override func numberOfRows() -> NSInteger {
        return 2
    }
    
    override func tableView(willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = "gitKong"
    }
    
    override func tableView(willDisplayHeaderView view: UITableViewHeaderFooterView, forSection section: Int) {
        print("headerView color is \(String(describing: view.contentView.backgroundColor))")
    }
    
    override func titleForHeader(at section: Int) -> NSMutableAttributedString? {
        let attStr = NSMutableAttributedString.init(string: "hello world,hello gitKong, i am header title test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test")
        // must add attribute,otherwise,calculate the wrong rect for attribute string
        attStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 17), range: NSRange.init(location: 0, length: attStr.length))
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange.init(location: 0, length: 5))
        return attStr
    }
    
    override func footerView(at section: Int) -> FLTableViewHeaderFooterView? {
        // just resue footerView,so call super.register()
        let footerView = super.footerView(at: section)
        footerView?.contentView.backgroundColor = UIColor.red
        return footerView
    }
    
    override func heightForFooter(at section: Int) -> CGFloat {
        return 20
    }
}