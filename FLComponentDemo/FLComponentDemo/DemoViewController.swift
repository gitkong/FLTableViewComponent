//
//  DemoViewController.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoViewController: FLComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var arr : Array<FLTableComponentConfiguration> = []
        
        let component = DemoComponent.init(tableView: self.tableView)
        let NibComponent = NibDemoComponent.init(tableView: self.tableView)

        arr.append(component)
        arr.append(NibComponent)
        self.components = arr
    }
    
    override var tableViewStyle: UITableViewStyle {
        return UITableViewStyle.grouped
    }

}
