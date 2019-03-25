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
    
    struct DailyForecast {
        var dailyMaxTemp: Double
        var dailyMinTemp: Double
        var dailySummary: String
        var dailyDate: Double
        var dailyIcon: String
        
    }
    
    struct HourlyForecast {
        var hourlyTime: Double
        var hourlyTemperature: Double
        var hourlyPrecipProb: Double
        var hourlyIcon: String
    }
    
    var name = ""
    var coordinates = ""
    var currentTemperature = "--"
    var dailySummary = ""
    var currentIcon = ""
    var currentTime = 0.0
    var timeZone = ""
    
    var dailyForecastArray = [DailyForecast]()
    var hourlyForecastArray = [HourlyForecast]()
    
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
                if let timeZone = json["timezone"].string {
                    self.timeZone = timeZone
                } else {
                    print("Could not return a timeZone")
                }
                if let time = json["currently"]["time"].double {
                    self.currentTime = time
                } else {
                    print("Could not return a time")
                }
                let dailyDataArray = json["daily"]["data"]
                self.dailyForecastArray = []
                let days = min(7, dailyDataArray.count-1)
                for day in 1...days {
                    let maxTemp = json["daily"]["data"][day]["temperatureHigh"].doubleValue
                    let minTemp = json["daily"]["data"][day]["temperatureLow"].doubleValue
                    let dateValue = json["daily"]["data"][day]["time"].doubleValue
                    let icon = json["daily"]["data"][day]["icon"].stringValue
                    let dailySummary = json["daily"]["data"][day]["summary"].stringValue
                    let newDailyForecast = DailyForecast(dailyMaxTemp: maxTemp, dailyMinTemp: minTemp, dailySummary: dailySummary, dailyDate: dateValue, dailyIcon: icon)
                    self.dailyForecastArray.append(newDailyForecast)
                }
                let hourlyDataArray = json["hourly"]["data"]
                self.hourlyForecastArray = []
                let hours = min(24, hourlyDataArray.count-1)
                for hour in 1...hours {
                    let hourlyTime = json["hourly"]["data"][hour]["time"].doubleValue
                    let hourlyTemperature = json["hourly"]["data"][hour]["temperature"].doubleValue
                    let hourlyPrecipProp = json["hourly"]["data"][hour]["precipProbability"].doubleValue
                    let hourlyIcon = json["hourly"]["data"][hour]["icon"].stringValue
                    let newHourlyForecast = HourlyForecast(hourlyTime: hourlyTime, hourlyTemperature: hourlyTemperature, hourlyPrecipProb: hourlyPrecipProp, hourlyIcon: hourlyIcon)
                    self.hourlyForecastArray.append(newHourlyForecast)
                }
                print("**** \(self.hourlyForecastArray)")
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
    
}
