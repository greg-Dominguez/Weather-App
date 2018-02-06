//
//  XibView.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/3/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import Foundation

import UIKit

protocol XibView {
    
    weak var contentView: UIView! { get }
    var xibName: String { get }
}

extension XibView {
    
    func setup(view: UIView){
        
        Bundle.main.loadNibNamed(xibName, owner: self, options: nil)
        view.addSubview(contentView)
        contentView.frame = view.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
