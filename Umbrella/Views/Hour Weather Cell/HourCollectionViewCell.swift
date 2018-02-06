//
//  HourCollectionViewCell.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/4/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    static let identifier = "HourForecastCell"
    static let height: CGFloat = 115
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWith(hourVM: HourForecastViewModel){
        
        timeLabel.text = hourVM.timeLocalized
        temperatureLabel.text = hourVM.temperature
        iconImageView.loadImage(urlString: hourVM.iconURL)
        
        if !(hourVM.coldest && hourVM.hottest) {
            if hourVM.coldest {
                timeLabel.textColor = UIColor.coldColor
                temperatureLabel.textColor = UIColor.coldColor
                iconImageView.tintColor = UIColor.coldColor
            }
            if hourVM.hottest {
                timeLabel.textColor = UIColor.hotColor
                temperatureLabel.textColor = UIColor.hotColor
                iconImageView.tintColor = UIColor.hotColor
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        timeLabel.textColor = UIColor.black
        temperatureLabel.textColor = UIColor.black
        iconImageView.tintColor = UIColor.clear
    }
    
}
