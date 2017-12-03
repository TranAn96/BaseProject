//
//  CollectionViewExtension.swift
//  LaleTore
//
//  Created by luckymanbk on 11/24/16.
//  Copyright © 2016 Paditech. All rights reserved.
//

import UIKit

public let kTagLabel = 9999999
public let kTagIndicator = 99999999

extension UICollectionView {
    
    func addIndicator(style: UIActivityIndicatorViewStyle) {
        if self.viewWithTag(kTagIndicator) == nil {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: style)
            indicator.tag = kTagIndicator
            indicator.center = self.center
            self.addSubview(indicator)
            indicator.startAnimating()
        }
    }
    
    func removeIndicator() {
        self.subviews.forEach {
            $0.viewWithTag(kTagIndicator)?.removeFromSuperview()
        }
    }
    }


