//
//  FLTableViewHeaderFooterView.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/12.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

enum FLTableViewHeaderFooterType {
    case Header
    case Footer
}

// MARK : use FLTableViewHeaderFooterView, because extension can not store properties or override method

class FLTableViewHeaderFooterView: UITableViewHeaderFooterView {
    // use this property because textLabel provided by UITableViewHeaderFooterView is not suitable
    public var titleLabel : UILabel = UILabel()
    
    public var section : Int?
    
    weak var delegate : FLTableComponentEvent?
    
    public var headerFooterType : FLTableViewHeaderFooterType = .Header
    
    // MARK : if you want header or footer view have accurate event handling capabilities, you should initialize with init(reuseIdentifier: String?, section: Int)
    convenience init(reuseIdentifier: String?, section: Int, headerFooterType: FLTableViewHeaderFooterType = .Header){
        self.init(reuseIdentifier: reuseIdentifier)
        self.section = section
        self.headerFooterType = headerFooterType
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        // create titleLabel
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.init(red: 0.43, green: 0.43, blue: 0.45, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(titleLabel)
        
        // add gesture
        let tapG : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.headerFooterDidClick))
        
        self.contentView.addGestureRecognizer(tapG)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect.init(x: 0, y: 0, width: self.bounds.size.width - FLHeaderFooterTitleLeftPadding * 2, height: self.bounds.size.height - FLHeaderFooterTitleTopPadding * 2)
        titleLabel.center = self.contentView.center
    }
    
    // MARK : why not use textLabel, because textLabel always offset upwards
    override var textLabel: UILabel?{
        print("warnning : textLabel will always return nil, please use titleLabel instead")
        return nil
    }
    
    // MARK : system warning Setting the background color on UITableViewHeaderFooterView has been deprecated. Please use contentView.backgroundColor instead.so overide it,but still warning
    
    override var backgroundColor: UIColor?{
        willSet{
            self.contentView.backgroundColor = newValue
        }
    }
    
//    var headerFooterViewClickOperation : (FLTableViewHeaderFooterType)->Void?
    
}

extension FLTableViewHeaderFooterView : FLTableComponentEvent{
    
    func headerFooterDidClick(){
//        headerFooterViewClickOperation(self.headerFooterType)
        switch self.headerFooterType {
        case .Header:
            delegate?.tableView!(didSelectHeaderViewAt: section!)
        default:
            delegate?.tableView!(didSelectFooterViewAt: section!)
        }
    }
}
