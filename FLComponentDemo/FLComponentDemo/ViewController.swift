//
//  ViewController.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "gitKong"
    }
    

    @IBAction func showTableViewComponent(_ sender: UIButton) {
        self.navigationController?.pushViewController(DemoViewController(), animated: true)
    }
    
    @IBAction func showCollectionViewComponent(_ sender: UIButton) {
        self.navigationController?.pushViewController(DemoCollectionViewController(), animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

