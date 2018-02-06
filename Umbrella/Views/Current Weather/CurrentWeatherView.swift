//
//  CurrentWeatherView.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/3/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import UIKit

protocol CurrentWeatherViewProtocol: class {
    
    func settingsButtonPressed()
}

class CurrentWeatherView: UIView, XibView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let xibName = "CurrentWeatherView"
    
    weak var delegate: CurrentWeatherViewProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup(view: self)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(view: self)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func configureWith(conditions: CurrentForecast){
        cityLabel.text = conditions.location
        degreeLabel.text = String(conditions.temperature) + "°"
        activityIndicator.stopAnimating()
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        delegate?.settingsButtonPressed()
    }
    
}

