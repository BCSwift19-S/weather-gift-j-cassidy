//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by James Cassidy on 3/18/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import Foundation
import Alamofire

class WeatherLocation {
    var name = ""
    var coordinates = ""
    
    func getWeather(){
        
        let weatherURL = urlBase + urlAPIKey + coordinates
        
        Alamofire.request(weatherURL).responseJSON{ response in
            print(response)
        }
    }

}
