//
//  WeatherModel.swift
//  Clima
//
//  Created by dola on 04/11/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel {
    // stroed property
    let conditionId : Int
    let cityName : String
    let tempreature : Double
    let feelsLike : Double
    let humadity : Double
    //computed proprety
    var conditionName : String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var tempratureString : String {
        
        return String(format: "%.1f", tempreature)
    }
    
    var fellsLikeString : String {
        
        return String(format: "%.1f", feelsLike)
    }
    
    var humadityString : String {
        
        return String(format: "%.1f", humadity)
    }
    
}
