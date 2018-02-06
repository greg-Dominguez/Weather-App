//
//  DayTableViewCell+CollectionViewDelegate.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/5/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import Foundation


import UIKit

extension DayTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension DayTableViewCell: UICollectionViewDelegateFlowLayout {
    
    var cellWidth: CGFloat {
        return (collectionView.frame.size.width)/4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: cellWidth, height: HourCollectionViewCell.height)
    }
    
}
