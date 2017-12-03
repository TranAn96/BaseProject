//
//  TableViewExtension.swift
//  LaleTore
//
//  Created by luckymanbk on 11/24/16.
//  Copyright © 2016 Paditech. All rights reserved.
//

import UIKit

public let kYPosition = CGFloat(44)

extension UITableView {
    
    func addIndicator(style: UIActivityIndicatorViewStyle, deltaCenterY: CGFloat = 0) {
        if self.viewWithTag(kTagIndicator) == nil {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: style)
            indicator.tag = kTagIndicator
            indicator.center = self.center
            indicator.centerY += deltaCenterY
            self.addSubview(indicator)
            indicator.startAnimating()
        }
    }
    
    func removeIndicator() {
        self.subviews.forEach {
            $0.viewWithTag(kTagIndicator)?.removeFromSuperview()
        }
    }
    
    
    func removeLabel() {
        self.subviews.forEach {
            $0.viewWithTag(kTagLabel)?.removeFromSuperview()
        }
    }
    
    func hideORShowVerticalScrollIndicator() {
        let contentHeight = self.contentSize.height
        let averageHeightRow = contentHeight / CGFloat(self.numberOfRows(inSection: 0))
        if contentHeight - averageHeightRow < UIScreen.height - CGFloat(64 + 44 + 49) {
            self.showsVerticalScrollIndicator = false
        } else {
            self.showsVerticalScrollIndicator = true
        }
    }
}
