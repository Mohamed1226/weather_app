
import UIKit
import CoreLocation
class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var detailsButton: UIButton!
    var weatherData : WeatherModel?

    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsButton.layer.cornerRadius = 25
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        searchTextField.delegate = self
        
    }
    

    
    @IBAction func detailsPressed(_ sender: UIButton) {
           self.performSegue(withIdentifier:"gotToDetailsWeather", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotToDetailsWeather" {
            let destination = segue.destination as! DetailsWeatherViewController
            destination.weather = weatherData
            
        }
    }
    @IBAction func getLocationPressed(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    

}

//MARK: -  CLLocationManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWearherWithLocation(lat: String(lat), lon: String(lon))
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate {
    @IBAction func searchButtonPreesed(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWearherWithName(cityName: city)
        }
        
        searchTextField.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Write some thing"
            return false
        }
    }
}

//MARK: - WeatherDelegate
extension WeatherViewController : WeatherDelegate {
    
    func updateWeather(_ weatherManager : WeatherManager ,weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherData = weather
            self.conditionImageView.image = UIImage(systemName:weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.font = UIFont(name: "", size: 30)
            self.temperatureLabel.text = weather.tempratureString
        }
    }
    func withError(error: Error) {
        print("error")
        print(error)
    }
}
