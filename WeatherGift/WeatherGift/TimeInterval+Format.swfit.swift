//
//  TimeInterval+Format.swfit.swift
//  WeatherGift
//
//  Created by James Cassidy on 3/25/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import Foundation

extension TimeInterval {
    func format(timeZone: String, dateFormatter: DateFormatter) -> String {
        let usableDate = Date(timeIntervalSince1970: self)
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usableDate)
        return dateString
    }
}
