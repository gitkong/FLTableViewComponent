//
//  FLCollectionComponentProtocol.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

@objc protocol FLCollectionComponentConfiguration : FLBaseComponentProtocol{
    
    // MARK : Custom UI,default collectionViewlayout is flowLayout, you can override the flowLayoutConfiguration method to custom flowLayout
    
    /// override this property in controller which inherited by FLCollectionComponentController to return custom layout, default is flowLayout
    @objc optional var collectionViewLayout : UICollectionViewLayout { get }
    
    /// if current collectionViewLayout is FLCollectionViewFlowLayout, you can override this method in controller which inherited by FLCollectionComponentController to configurate current flowLayout
    ///
    /// - Parameter flowLayout: current flowLayout
    @objc optional func flowLayoutConfiguration(_ flowLayout : FLCollectionViewFlowLayout)
    
    /// if current collectionViewLayout is FLCollectionViewFlowLayout, you can set style for current flowLayout, default is .System. Attention, you can not override this property
    @objc optional var flowLayoutStyle : FLCollectionViewFlowLayoutStyle { get set }
    
    /// override this method in component which inherited by FLCollectionBaseComponent to set current component sectionInset, default is .zero
    ///
    /// - Returns: component sectionInset
    @objc optional func sectionInset() -> UIEdgeInsets
    
    /// override this method in component which inherited by FLCollectionBaseComponent to set current component minimumLineSpacing, if you did not override it, default is the value in minimumLineSpacing property of flowLayout
    ///
    /// - Returns: component minimumLineSpacing
    @objc optional func minimumLineSpacing() -> CGFloat
    
    /// override this method in component which inherited by FLCollectionBaseComponent to set current component minimumInteritemSpacing, if you did not override it, default is the value in minimumInteritemSpacing property of flowLayout
    ///
    /// - Returns: component minimumInteritemSpacing
    @objc optional func minimumInteritemSpacing() -> CGFloat
    
    // MARK : DataSource configuration
    
    /// override this method in component to set number of items for current section, default   is 0
    ///
    /// - Returns: number of items for current section
    @objc optional func numberOfItems() -> NSInteger
    
    /// override this method in component to set custom cell, default is FLCollectionViewCell which registed as the class of FLCollectionViewCell, if you want to custom cell and change the value of the custom cell properties, you should create a new cell inherited from FLCollectionViewCell
    ///
    /// - Parameter item: current item
    /// - Returns: cell for current item
    @objc optional func cellForItem(at item: Int) -> UICollectionViewCell
    
    /// override this method in component to perform additional operation, such as add lable or button into headerView to resue, but you can not change it again,because this dost not call when the cell prepare to reuse, Attention,you must regist first
    ///
    /// - Parameter cell:  cell for ready to reuse
    @objc optional func additionalOperationForReuseCell(_ cell : FLCollectionViewCell?)
    
    /// if current collectionViewLayout is kind of FLCollectionViewFlowLayout, you can override this method in component to set the size for current cell, if you did not override it, default is the itemSize of flowLayout
    ///
    /// - Parameters:
    ///   - item: current item
    /// - Returns: the size of current item
    @objc optional func sizeForItem(at item: Int) -> CGSize
    
    // MARK : Header or footer view customization
    
    /// override this method in component to custom headerView for current component, default is FLCollectionHeaderFooterView which registed as the class of FLCollectionHeaderFooterView, Attention,you must regist first
    ///
    /// - Returns: custom headerView for current component
    @objc optional func headerView() -> FLCollectionHeaderFooterView
    
    /// override this method in component to custom footerView for current component, default is FLCollectionHeaderFooterView which registed as the class of FLCollectionHeaderFooterView, Attention,you must regist first
    ///
    /// - Returns: custom footerView for current component
    @objc optional func footerView() -> FLCollectionHeaderFooterView
    
    /// override this method in component to perform additional operation, such as add lable or button into headerView to resue, Attention,you must regist first
    ///
    /// - Parameter headerView:  headerView for ready to reuse
    @objc optional func additionalOperationForReuseHeaderView(_ headerView : FLCollectionHeaderFooterView?)
    
    
    /// override this method in component to perform additional operation, such as add lable or button into footerView to resue, Attention,you must regist first
    ///
    /// - Parameter footerView: footerView for ready to reuse
    @objc optional func additionalOperationForReuseFooterView(_ footerView : FLCollectionHeaderFooterView?)
    
    /// override this method in component to custom the height of headerView for current component, default is 0
    ///
    /// - Returns: custom the height of headerView for current component
    @objc optional func heightForHeader() -> CGFloat
    
    /// override this method in component to custom the height of footerView for current component, default is 0
    ///
    /// - Returns: custom the height of footerView for current component
    @objc optional func heightForFooter() -> CGFloat
    
    // MARK : Display customization
    
    /// this method will call when the cell will display
    ///
    /// - Parameters:
    ///   - cell: current cell which will display
    ///   - item: current item
    @objc optional func collectionView(willDisplayCell cell: UICollectionViewCell, at item: Int)
    
    /// this method will call when the cell did displayed
    ///
    /// - Parameters:
    ///   - cell: the cell which did displayed
    ///   - item: current item
    @objc optional func collectionView(didEndDisplayCell cell: UICollectionViewCell, at item: Int)
    
    /// this method will call when the headerView will display
    ///
    /// - Parameter view: headerView which will display
    @objc optional func collectionView(willDisplayHeaderView view: FLCollectionHeaderFooterView)
    
    /// this method will call when the headerView did displayed
    ///
    /// - Parameter view: headerView which did displayed
    @objc optional func collectionView(didEndDisplayHeaderView view: FLCollectionHeaderFooterView)
    
    /// this method will call when the footerView will display
    ///
    /// - Parameter view: footerView which will display
    @objc optional func collectionView(willDisplayFooterView view: FLCollectionHeaderFooterView)
    
    /// this method will call when the footerView did displayed
    ///
    /// - Parameter view: footerView which did displayed
    @objc optional func collectionView(didEndDisplayFooterView view: FLCollectionHeaderFooterView)
    
    // MARK : Managing Actions for Cells
    
    /// Asks the component if an action menu should be displayed for the specified item.If the user tap-holds a certain item in the collection view, this method (if implemented) is invoked first.
    ///
    /// - Parameter item: current item
    /// - Returns: true if the editing menu should be shown positioned near the item and pointing to it or false if it should not.
    @objc optional func shouldShowMenu(at item: Int) -> Bool
    
    /// Asks the component if it can perform the specified action on an item in the collection view, This method is invoked after the shouldShowMenu(at item:) method. It gives you the opportunity to exclude commands from the editing menu.
    ///
    /// - Parameters:
    ///   - selector: The selector identifying the action to be performed.
    ///   - forItemAt: current item
    ///   - withSender: The object that wants to initiate the action.
    /// - Returns: true if the command corresponding to action should appear in the editing menu or false if it should not.
    @objc optional func canPerform(selector : Selector, forItemAt: Int, withSender: Any?) -> Bool
    
    /// Tells the component to perform the specified action on an item in the collection view.
    ///
    /// - Parameters:
    ///   - selector: The selector representing the action to be performed.
    ///   - forItemAt: current item
    ///   - withSender: The object that initiated the action.
    @objc optional func perform(selector : Selector, forItemAt: Int, withSender: Any?)
}

@objc protocol FLCollectionComponentEvent {
    
    // Header or Footer tapping event
    
    /// override this method in controller to handle the event of headerView tapping
    ///
    /// - Parameters:
    ///   - headerView: current component's headerView
    ///   - section: current component's section
    @objc optional func collectionHeaderView(_  headerView : FLCollectionHeaderFooterView, didClickSectionAt section: Int)
    
    /// override this method in controller to handle the event of footerView tapping
    ///
    /// - Parameters:
    ///   - headerView: current component's footerView
    ///   - section: current component's section
    @objc optional func collectionFooterView(_  footerView : FLCollectionHeaderFooterView, didClickSectionAt section: Int)
    
}
