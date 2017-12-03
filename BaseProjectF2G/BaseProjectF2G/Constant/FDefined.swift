//
//  DQDefined.swift
//  DQ_User
//
//  Created by Gio Viet on 2/17/17.
//  Copyright © 2017 Paditech Inc. All rights reserved.
//

import UIKit

class FDefined: NSObject {
    static func fontRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    static func fontBold(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    static func fontLight(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size)!
    }
    
    static func fontCondensedBold(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-CondensedBold", size: size)!
    }
    
    static let mainColor = UIColor.colorFromHexString(hex: "#18c3bb")
    static let grayColor = UIColor.colorFromHexString(hex: "e0e0e0")
}
