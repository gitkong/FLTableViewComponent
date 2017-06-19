//
//  TestViewController.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/6/16.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, FLTableViewHandlerDelegate {

    var handler : FLTableViewHandler?
    var secondHandler : FLTableViewHandler?
    
    var collectionViewHandler : FLCollectionViewHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        
        let flowLayout = FLCollectionViewFlowLayout.init(with: FLCollectionViewFlowLayoutStyle.Custom)
        let collectionView : UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.bounds.width, height: 300) , collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionViewHandler = FLCollectionViewHandler.init()
        var collectionArr : Array<FLCollectionBaseComponent> = []
        
        let collectionComponent = DemoCollectionComponentOne(collectionView: collectionView)
        collectionArr.append(collectionComponent)
        collectionArr.append(DemoCollectionComponentTwo(collectionView: collectionView))
        collectionArr.append(collectionComponent)
        collectionArr.append(DemoCollectionComponentTwo(collectionView: collectionView))
        collectionArr.append(collectionComponent)
        collectionArr.append(DemoCollectionComponentTwo(collectionView: collectionView))
        collectionViewHandler?.components = collectionArr
        flowLayout.delegate = collectionViewHandler
        collectionView.handler = collectionViewHandler
        self.view.addSubview(collectionView)
        
        let secondTableView : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.bounds.width, height: 300), style: UITableViewStyle.grouped)
//        self.view.addSubview(secondTableView)
        
        let tableView : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: secondTableView.frame.origin.y + secondTableView.frame.height, width: self.view.bounds.width, height: self.view.bounds.height - secondTableView.frame.origin.y - secondTableView.frame.height), style: UITableViewStyle.plain)
        
        self.view.addSubview(tableView)
        
        var arr : Array<FLTableBaseComponent> = []
        
        let component = DemoComponent.init(tableView: tableView)
        let NibComponent = NibDemoComponent.init(tableView: tableView)
        
        arr.append(component)
        arr.append(NibComponent)
        
        handler = FLTableViewHandler.init()
        handler?.components = arr
        handler?.delegate = self
        tableView.handler = handler
        tableView.reloadData()
        
        
        var secondArr : Array<FLTableBaseComponent> = []
        
        let secondComponent = DemoComponent.init(tableView: secondTableView)
        let secondNibComponent = NibDemoComponent.init(tableView: secondTableView)
        
        secondArr.append(secondComponent)
        secondArr.append(secondNibComponent)
        secondHandler = FLTableViewHandler.init()
        secondHandler?.components = secondArr
        
        secondHandler?.delegate = self
        secondTableView.handler = secondHandler
        secondTableView.reloadData()
    }

    func tableViewDidClick(handler: FLTableViewHandler, cellAt: IndexPath) {
        if handler == self.handler {
            print("second tableView cell")
        }
        else {
            print("first tableView cell")
        }
    }
    
    func tableViewDidClick(handler: FLTableViewHandler, headerAt: NSInteger) {
        if handler == self.handler {
            print("second tableView header")
        }
        else {
            print("first tableView header")
        }
    }
    
    func tableViewDidClick(handler: FLTableViewHandler, footerAt: NSInteger) {
        if handler == self.handler {
            print("second tableView footer")
        }
        else {
            print("first tableView footer")
        }
    }

}
