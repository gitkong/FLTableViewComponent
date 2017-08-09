//
//  FLTableComponentConfiguration.swift
//  FLComponentDemo
//
//  Created by gitKong on 2017/5/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

// MARK : you can override this protocol methods

import UIKit

@objc protocol FLTableComponentConfiguration : FLBaseComponentProtocol {
    
    // custom UI,default tableView is plain
    
    /// override this property in controller to change current tableView style
    @objc optional var tableViewStyle : UITableViewStyle { get }
    
    /// override this property in component to change current tableViewCell style, default is .default
    @objc optional var tableViewCellStyle : UITableViewCellStyle { get }
    
    // dataSource configuration
    
    /// override this method in component to set number of rows for current section, default   is 0
    ///
    /// - Returns: number of rows for current section
    @objc optional func numberOfRows() -> NSInteger
    
    /// override this method in component to set custom cell, you can call super to get reusable cell,default is UITableViewCell which registed as the class of UITableViewCell, if your cell is created from Nib, you must have to regist Nib cell first
    ///
    /// - Parameter item: current row
    /// - Returns: cell for current row
    @objc optional func cellForRow(at row: Int) -> UITableViewCell
    
    /// override this method in component to perform additional operation, such as add lable or button into cell to resue, but if you had registed the class of UITableViewCell for headerView, this method will be invalid, so if you want it to be valiable, do not regist cell
    ///
    /// - Parameter cell: custom cell
    @objc optional func additionalOperationForReuseCell(_ cell : UITableViewCell?)
    
    // header or footer customizaion
    
    /// when you override this method, you can call super to get reusable headerView, and override additionalOperationForReuseHeaderView(_ headerView:) method to add new UI to reuse
    ///
    /// - Returns: custom headerView for current component
    @objc optional func headerView() -> FLTableViewHeaderFooterView?
    
    /// when you override this method, you can call super to get reusable footerView, and override additionalOperationForReuseFooterView(_ footerView:) method to add new UI to reuse
    ///
    /// - Returns: custom footerView for current component
    @objc optional func footerView() -> FLTableViewHeaderFooterView?
    
    /// override this method in component to perform additional operation, such as add lable or button into headerView to resue, but if you had registed the class of FLTableViewHeaderFooterView for headerView, this method will be invalid, so if you want it to be valiable, do not call super when you override register() method
    ///
    /// - Parameter headerView:  headerView for ready to reuse
    @objc optional func additionalOperationForReuseHeaderView(_ headerView : FLTableViewHeaderFooterView?)
    
    
    /// override this method in component to perform additional operation, such as add lable or button into footerView to resue, but if you had registed the class of FLTableViewHeaderFooterView for footerView, this method will be invalid, so if you want it to be valiable, do not call super when you override register() method
    ///
    /// - Parameter footerView: footerView for ready to reuse
    @objc optional func additionalOperationForReuseFooterView(_ footerView : FLTableViewHeaderFooterView?)
    
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
    
    // Highlight control
    
    @objc optional func tableView(shouldHighlight cell: UITableViewCell?, at row: Int) -> Bool
    
    @objc optional func tableView(didHighlight cell: UITableViewCell?, at row: Int)
    
    @objc optional func tableView(didUnHighlight cell: UITableViewCell?, at row: Int)
    
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
