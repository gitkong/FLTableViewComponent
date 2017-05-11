//
//  DemoComponent.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoComponent: FLBaseComponent {
    
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
    
    override func headerView(at section: Int) -> UITableViewHeaderFooterView? {
        
        return nil
    }
    
    override func tableView(willDisplayHeaderView view: UITableViewHeaderFooterView, forSection section: Int) {
        if view == nil {
            print("headerView is empty")
        }
    }
}
