//
//  WeatherData.swift
//  Clima
//
//  Created by dola on 04/11/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherFromJson : Codable{
    let name : String
    
    let main : Main
    
    let weather : [Temperature]
}

struct Main : Codable{
    let feels_like : Double
    let temp : Double
    let humidity : Double
}


struct Temperature : Codable {
    let id : Int
    
}
