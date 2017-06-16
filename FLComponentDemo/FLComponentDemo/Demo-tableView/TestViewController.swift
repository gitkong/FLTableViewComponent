//
//  TestViewController.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/6/16.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var handler : FLTableViewHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        let tableView : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 300, width: self.view.bounds.width, height: self.view.bounds.height - 300), style: UITableViewStyle.plain)
        
        self.view.addSubview(tableView)
        
        
        var arr : Array<FLTableBaseComponent> = []
        
        let component = DemoComponent.init(tableView: tableView)
        let NibComponent = NibDemoComponent.init(tableView: tableView)
        
        arr.append(component)
        arr.append(NibComponent)
        
        handler = FLTableViewHandler.init()
        handler!.components = arr
        
        tableView.dataSource = handler!
        tableView.delegate = handler!
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
