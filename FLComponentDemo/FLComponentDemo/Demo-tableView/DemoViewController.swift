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
        title = "gitKong"
        var arr : Array<FLTableBaseComponent> = []
        
        let component = DemoComponent.init(tableView: self.tableView)
        let NibComponent = NibDemoComponent.init(tableView: self.tableView)

        arr.append(component)
        arr.append(NibComponent)
        self.components = arr
        
        self.components.append(component)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "add", style: .done, target: self, action: #selector(self.addElement))
    }
    
    func addElement() {
        self.components.append(NibDemoComponent.init(tableView: self.tableView))
        self.reloadComponent()
    }
    
    override var tableViewStyle: UITableViewStyle {
        return UITableViewStyle.grouped
    }
    
    override var customRect : CGRect {
        return self.view.bounds
    }
    
    override func headerView(of tableView: UITableView) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    override func footerView(of tableView: UITableView) -> UIView? {
        return nil
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
