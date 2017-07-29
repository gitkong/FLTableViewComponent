//
//  DemoViewController.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class DemoViewController: FLTableComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "gitKong"
        var arr : Array<FLTableBaseComponent> = []
        
        let component = DemoComponent.init(tableView: self.tableView, identifier : "gitKong_DemoComponent")
        let NibComponent = NibDemoComponent.init(tableView: self.tableView, identifier : "gitKong_NibComponent")
        let component1 = DemoComponent.init(tableView: self.tableView, identifier : "gitKong_DemoComponent_different")
        let NibComponent1 = NibDemoComponent.init(tableView: self.tableView)
        arr.append(component)
        arr.append(NibComponent)
//        arr.append(component)
        arr.append(NibComponent1)
        self.components = arr
        
        
        self.components.append(component1)
        
        for component in components {
            print(component.componentIdentifier)
        }
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "add", style: .done, target: self, action: #selector(self.addElement))
    }
    
    func addElement() {
//        self.handler.addAfterSection(NibDemoComponent.init(tableView: self.tableView), after: 1)
//        let newComponent = NibDemoComponent.init(tableView: self.tableView)
        
        if let firstComponent = self.handler.component(by: "gitKong_DemoComponent"), let secondComponent = self.handler.component(by: "gitKong_NibComponent") {
//            self.handler.replace(component, by: newComponent)
            self.handler.exchange(firstComponent, by: secondComponent)
        }
        
        self.reloadComponent()
        
//        self.handler.removeComponent(by: "gitKong_DemoComponent", removeType: .All)
//        self.handler.removeComponent(at: 1)
//        self.handler.reloadComponents()
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
    
    override func tableViewDidClick(_ handler: FLTableViewHandler, cellAt indexPath: IndexPath) {
        let cell  =  handler.cellForRow(at: indexPath)
        if cell is NibDemoTableViewCell {
            print("NIB")
        }
        
        print("section-\(indexPath.section), row-\(indexPath.row)")
    }
    
    override func tableViewDidClick(_ handler: FLTableViewHandler, headerAt section: NSInteger) {
        let headerView = handler.headerView(forSection: section)
        print("header-\(section)-title = \(String(describing: headerView?.titleLabel.text))")
    }
    
    override func tableViewDidClick(_ handler: FLTableViewHandler, footerAt section: NSInteger) {
        let footerView = handler.footerView(forSection: section)
        print("footer-\(section)-title = \(String(describing: footerView?.titleLabel.text))")
    }

}
