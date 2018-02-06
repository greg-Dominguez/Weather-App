//
//  Extensions+UIColor.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/3/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import UIKit

extension UIColor {

    // #03A9F4
    class var coldColor: UIColor {
        let r = CGFloat(Float(3)/Float(255.0))
        let g = CGFloat(Float(169)/Float(255.0))
        let b = CGFloat(Float(244)/Float(255.0))
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    // #FF9800
    class var hotColor: UIColor {
        
        let r = CGFloat(Float(255)/Float(255.0))
        let g = CGFloat(Float(152)/Float(255.0))
        let b: CGFloat = 0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }

}
