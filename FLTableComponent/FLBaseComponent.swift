//
//  FLBaseComponent.swift
//  FLComponentDemo
//
//  Created by Lyon on 2017/5/17.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

let FLHeaderFooterTitleTopPadding : CGFloat = 5
let FLHeaderFooterTitleLeftPadding : CGFloat = 20

enum FLIdentifierType  : String{
    case Cell = "cell"
    case Header = "header"
    case Footer = "footer"
    
    static func type(of  reuseIdentifier : String?) -> FLIdentifierType? {
        if let reuseId = reuseIdentifier {
            if reuseId.hasSuffix(FLIdentifierType.Header.rawValue) {
                return .Header
            }
            else if reuseId.hasSuffix(FLIdentifierType.Footer.rawValue) {
                return .Footer
            }
            else {
                return .Cell
            }
        }
        return nil
    }
}
class FLBaseComponent: NSObject, FLBaseComponentProtocol {
    
    final var cellIdentifier : String {
        return "\(NSStringFromClass(type(of: self))).\(FLIdentifierType.Cell.rawValue)"
    }
    
    final var footerIdentifier: String {
        return "\(NSStringFromClass(type(of: self))).\(FLIdentifierType.Footer.rawValue)"
    }
    
    final var headerIdentifier: String {
        return "\(NSStringFromClass(type(of: self))).\(FLIdentifierType.Header.rawValue)"
    }
    
    dynamic func register() {
        // regist cell、header、footer
    }
    
}
