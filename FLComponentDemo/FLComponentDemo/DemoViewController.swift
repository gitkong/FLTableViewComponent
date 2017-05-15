//
//  DemoViewController.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoViewController: FLTableComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var arr : Array<FLTableBaseComponent> = []
        
        let component = DemoComponent.init(tableView: self.tableView)
        let NibComponent = NibDemoComponent.init(tableView: self.tableView)

        arr.append(component)
        arr.append(component)
        arr.append(component)
        arr.append(NibComponent)
        arr.append(NibComponent)
        self.components = arr
    }
    
    override var tableViewStyle: UITableViewStyle {
        return UITableViewStyle.grouped
    }
    
    override func tableHeaderView(_ headerView: FLTableViewHeaderFooterView, didClickSectionAt section: Int) {
        print("header-\(section)-title = \(String(describing: headerView.titleLabel.text))")
    }
    
    override func tableFooterView(_ footerView: FLTableViewHeaderFooterView, didClickSectionAt section: Int) {
        print("footer-\(section)-title = \(String(describing: footerView.titleLabel.text))")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section-\(indexPath.section), row-\(indexPath.row)")
    }

}
