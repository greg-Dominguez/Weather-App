//
//  ViewController.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/3/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var currentWeatherView: CurrentWeatherView!
    @IBOutlet weak var forecastTableView: UITableView!
    
    var forecastDays: [Day] = []
    var cellHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        currentWeatherView.delegate = self
        WeatherDataManager.shared.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView(){
        let dayNib = UINib(nibName: "DayTableViewCell", bundle: nil)
        forecastTableView.register(dayNib, forCellReuseIdentifier:  DayTableViewCell.identifier)
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueID = segue.identifier else { return }
        
        switch segueID {
        case "ZipcodeSegue":
            
            guard let vc = segue.destination as? ZipcodeViewController else {
                return
            }
            vc.delegate = self
            
        default:
            break
        }
    }
}

extension HomeViewController: CurrentWeatherViewProtocol {
    
    func settingsButtonPressed() {
        performSegue(withIdentifier: "ZipcodeSegue", sender: nil)
    }
}

extension HomeViewController: ZipcodeVCDelegate {
    
    func zipcodeEntered() {
        WeatherDataManager.shared.reloadData()
    }
}

extension HomeViewController: WeatherDataDelegate {
    
    func updateForecast(days: [Day]) {
        
        forecastDays = days
        cellHeights = Array(repeating: DayTableViewCell.startingHeight, count: forecastDays.count)
        DispatchQueue.main.async {
            self.forecastTableView.reloadData()
        }        
    }
    
    func updateCurrentConditions(current: CurrentForecast) {
        DispatchQueue.main.async {
            self.currentWeatherView.configureWith(conditions: current)
        }
    }
    
    func requestZipCode() {
        performSegue(withIdentifier: "ZipcodeSegue", sender: nil)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DayTableViewCell.identifier, for: indexPath)
        
        guard let dayCell = cell as? DayTableViewCell else {
            fatalError("Identifier/Class mismatch")
        }
        
        let day = forecastDays[indexPath.row]
        dayCell.configureWith(day: day)
        cellHeights[indexPath.row] = dayCell.height
        
        return dayCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastDays.count
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeights[indexPath.row]
        //return (tableView.cellForRow(at: indexPath) as? DayTableViewCell)?.height ?? 0
    }
    
}



