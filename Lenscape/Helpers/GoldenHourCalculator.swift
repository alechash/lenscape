//
//  GoldenHourCalculator.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/9/24.
//

import Foundation
import CoreLocation
import Solar
import SunKit

struct GoldenHourCalculator {
    static func calculate(for location: CLLocationCoordinate2D) -> (theSun: Sun?, tz: TimeZone?) {
        guard let solar = Solar(for: Date(), coordinate: location) else {
            return (nil, nil)
        }
        
        guard let tomorrowSolar = Solar(for: Date.tomorrow, coordinate: location) else {
            return (nil, nil)
        }

        let sunrise = solar.sunrise
        let sunset = solar.sunset
        let tSunrise = tomorrowSolar.sunrise
        
        let tz = CLLocation(latitude: location.latitude, longitude: location.longitude).timeZone
        
        var mySun: Sun = .init(location: CLLocation(latitude: location.latitude, longitude: location.longitude), timeZone: tz)

        // Golden hour is typically the first hour after sunrise and the last hour before sunset
        let morningGoldenHour = sunrise?.addingTimeInterval(60 * 60) // One hour after sunrise
        let tomorrowMorningGoldenHour = tSunrise?.addingTimeInterval(60 * 60) // One hour after sunrise
        let eveningGoldenHour = sunset?.addingTimeInterval(-60 * 60) // One hour before sunset

        return (
            mySun,
            tz
        )
    }
}

extension Date {
   static var tomorrow:  Date { return Date().dayAfter }
   static var today: Date {return Date()}
   var dayAfter: Date {
      return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
   }
}
