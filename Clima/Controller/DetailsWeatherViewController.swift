//
//  DetailsWeatherViewController.swift
//  Clima
//
//  Created by dola on 06/11/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

class DetailsWeatherViewController: UIViewController {

    
    @IBOutlet weak var feels: UILabel!
    
    @IBOutlet weak var humadity: UILabel!

    var weather : WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        humadity.textColor = .green
        feels.textColor = .green
        humadity.text = weather?.humadityString
        feels.text = weather?.fellsLikeString
        
    }
    




}
