//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by James Cassidy on 3/18/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var coordinates = ""
    var currentTemperature = "--"
    var dailySummary = ""
    var currentIcon = ""
    
    func getWeather(completed: @escaping () -> ()){
        
        let weatherURL = urlBase + urlAPIKey + coordinates
        
        Alamofire.request(weatherURL).responseJSON{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemperature = roundedTemp + "°"
                } else {
                    print("Could not retrieve temperature.")
                }
                if let summary = json["daily"]["summary"].string {
                    self.dailySummary = summary
                } else {
                    print("Could not retrieve summary.")
                }
                if let icon = json["currently"]["icon"].string {
                    self.currentIcon = icon
                } else {
                    print("Could not retrieve icon.")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }

}
