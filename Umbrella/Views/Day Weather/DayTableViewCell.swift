//
//  DayTableViewCell.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/3/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerBackgroundView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier = "DayForecastCell"
    static let calendar = Calendar.current
    
    static let startingHeight: CGFloat = 82
    
    var hourVMs: [HourForecastViewModel] = []
    
    var height: CGFloat {
        return DayTableViewCell.startingHeight +
                CGFloat(Int(hourVMs.count/4)) * HourCollectionViewCell.height +
        ((hourVMs.count % 4 > 0) ? HourCollectionViewCell.height : 0)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let hourNib = UINib(nibName: "HourCollectionViewCell", bundle: nil)
        collectionView.register(hourNib, forCellWithReuseIdentifier: HourCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        selectionStyle = .none
        contentView.sendSubview(toBack: headerBackgroundView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let f = contentView.frame
        let fr = UIEdgeInsetsInsetRect(f, UIEdgeInsetsMake(10, 10, 10, 10))
        contentView.frame = fr
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWith(day: Day){
        
        handleDayLabel(offset: day.dayOffset)
        handleHours(hours: day.hours)
        collectionView.reloadData()
        contentView.layer.cornerRadius = 5.0
    }
    
    private func handleDayLabel(offset: Int){
        
        switch offset {
        case 0:
            dayLabel.text = "Today"
        case 1:
            dayLabel.text = "Tomorrow"
        default:
            let day = Calendar.current.date(byAdding: .day, value: offset, to: Date())
            dayLabel.text = day?.weekdayName
        }
    }
    
    private func handleHours(hours: [HourForecast]){
        
        hourVMs.removeAll()
        
        // (temperature, index) of the coldest and hottest hours
        var coldest = (Int.max, 0)
        var hottest = (Int.min, 0)
        
        for (i, hour) in hours.enumerated() {
            let vm = HourForecastViewModel(hour: hour)
            hourVMs.append(vm)
            
            if hour.temperature < coldest.0 {
                //new coldest temp
                coldest = (hour.temperature, i)
            }
            if hour.temperature > hottest.0 {
                //new hottest temp
                hottest = (hour.temperature, i)
            }
        }
        hourVMs[coldest.1].coldest = true
        hourVMs[hottest.1].hottest = true
    }
}






