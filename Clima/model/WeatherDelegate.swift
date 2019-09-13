//
//  WeatherDelegate.swift
//  Clima
//
//  Created by dola on 04/11/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


protocol WeatherDelegate {
    func updateWeather(_ weatherManager : WeatherManager ,weather: WeatherModel)
    func withError(error : Error)
}
