//
//  HourlyWeatherCell.swift
//  WeatherGift
//
//  Created by James Cassidy on 3/25/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "ha"
    return dateFormatter
}()

class HourlyWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var hourlyTime: UILabel!
    @IBOutlet weak var hourlyTemp: UILabel!
    @IBOutlet weak var hourlyIcon: UIImageView!
    @IBOutlet weak var rainDropImage: UIImageView!
    @IBOutlet weak var hourlyPrecipProb: UILabel!
    
    
    func update(with hourlyForecast: WeatherDetail.HourlyForecast, timeZone: String){
        hourlyTemp.text = String(format: "%2.f", hourlyForecast.hourlyTemperature) + "°"
        hourlyIcon.image = UIImage(named: "small-" + hourlyForecast.hourlyIcon)
        let precipProb = hourlyForecast.hourlyPrecipProb * 100
        hourlyPrecipProb.text = String(format: "%2.f", precipProb) + "%"
        let isHidden = precipProb < 40.0
        hourlyPrecipProb.isHidden = isHidden
        rainDropImage.isHidden = isHidden
        let dateString = hourlyForecast.hourlyTime.format(timeZone: timeZone, dateFormatter: dateFormatter)
        hourlyTime.text = dateString
    }
}
