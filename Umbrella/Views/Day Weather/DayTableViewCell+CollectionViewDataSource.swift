//
//  DayTableViewCell+CollectionViewDataSource.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/5/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import UIKit

extension DayTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.identifier, for: indexPath)
        
        guard let hourCell = cell as? HourCollectionViewCell else {
            fatalError("Cell/Identifier mismatch")
        }
        
        hourCell.configureWith(hourVM: hourVMs[indexPath.row])
        return hourCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourVMs.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
