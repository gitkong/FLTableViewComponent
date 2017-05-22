//
//  FLTableComponentConfiguration.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

// MARK : you can override this protocol methods

import UIKit

@objc protocol FLTableComponentConfiguration : FLBaseComponentProtocol {
    
    // custom UI,default tableView is plain
    
    /// override this property in controller to change current tableView style
    @objc optional var tableViewStyle : UITableViewStyle { get }
    
    // dataSource configuration
    
    /// override this method in component to set number of rows for current section, default   is 0
    ///
    /// - Returns: number of rows for current section
    @objc optional func numberOfRows() -> NSInteger
    
    /// override this method in component to set custom cell, default is UITableViewCell which registed as the class of UITableViewCell
    ///
    /// - Parameter item: current row
    /// - Returns: cell for current row
    @objc optional func cellForRow(at row: Int) -> UITableViewCell
    
    // header or footer customizaion
    
    /// override this method in component to custom headerView for current component, default is FLTableViewHeaderFooterView which registed as the class of FLTableViewHeaderFooterView
    ///
    /// - Returns: custom headerView for current component
    @objc optional func headerView() -> FLTableViewHeaderFooterView?
    
    /// override this method in component to custom footerView for current component, default is UICollectionReusableView which registed as the class of UICollectionReusableView
    ///
    /// - Returns: custom footerView for current component
    @objc optional func footerView() -> FLTableViewHeaderFooterView?
    
    /// override this method to set a mutable attribute string for headerView
    ///
    /// - Returns: mutable attribute string
    @objc optional func titleForHeader() -> NSMutableAttributedString?
    
    /// override this method to set a mutable attribute string for footerView
    ///
    /// - Returns: mutable attribute string
    @objc optional func titleForFooter() -> NSMutableAttributedString?
    
    // height customization
    
    /// override this method in component to custom the height for cell , default is 44.0
    ///
    /// - Parameter row: current row
    /// - Returns: custom height for cell
    @objc optional func heightForRow(at row: Int) -> CGFloat
    
    /// override this method in component to custom the height of headerView for current component, default is .leastNormalMagnitude
    ///
    /// - Returns: custom the height of headerView for current component
    @objc optional func heightForHeader() -> CGFloat
    
    /// override this method in component to custom the height of footerView for current component, default is .leastNormalMagnitude
    ///
    /// - Returns: custom the height of footerView for current component
    @objc optional func heightForFooter() -> CGFloat
    
    // Display customization
    
    /// this method will call when the cell will display
    ///
    /// - Parameters:
    ///   - cell: current cell which will display
    ///   - row: current row
    @objc optional func tableView(willDisplayCell cell: UITableViewCell, at row: Int)
    
    /// this method will call when the cell did displayed
    ///
    /// - Parameters:
    ///   - cell: the cell which did displayed
    ///   - row: current row
    @objc optional func tableView(didEndDisplayCell cell: UITableViewCell, at row: Int)
    
    /// this method will call when the headerView will display
    ///
    /// - Parameter view: headerView which will display
    @objc optional func tableView(willDisplayHeaderView view: FLTableViewHeaderFooterView)
    
    /// this method will call when the footerView will display
    ///
    /// - Parameter view: footerView which will display
    @objc optional func tableView(willDisplayFooterView view: FLTableViewHeaderFooterView)
    
    /// this method will call when the headerView did displayed
    ///
    /// - Parameter view: headerView which did displayed
    @objc optional func tableView(didEndDisplayHeaderView view: FLTableViewHeaderFooterView)
    
    /// this method will call when the footerView did displayed
    ///
    /// - Parameter view: footerView which did displayed
    @objc optional func tableView(didEndDisplayFooterView view: FLTableViewHeaderFooterView)
}

@objc protocol FLTableComponentEvent {
    
    // Header or Footer tapping event
    
    /// override this method in controller to handle the event of headerView tapping
    ///
    /// - Parameters:
    ///   - headerView: current component's headerView
    ///   - section: current component's section
    @objc optional func tableHeaderView(_  headerView : FLTableViewHeaderFooterView, didClickSectionAt section: Int)
    
    /// override this method in controller to handle the event of footerView tapping
    ///
    /// - Parameters:
    ///   - headerView: current component's footerView
    ///   - section: current component's section
    @objc optional func tableFooterView(_  footerView : FLTableViewHeaderFooterView, didClickSectionAt section: Int)
    
}
