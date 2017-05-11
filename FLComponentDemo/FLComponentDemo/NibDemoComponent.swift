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
        self.tableView?.registerNib(className: NibDemoTableViewCell.self, cellReuseIdentifier: self.cellIdentifier)
    }
    
    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        let cell : NibDemoTableViewCell = super.cellForRow(at: indexPath) as! NibDemoTableViewCell
        return cell
    }
    
    override func numberOfRows() -> NSInteger {
        return 3
    }
}
