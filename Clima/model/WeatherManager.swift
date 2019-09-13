import Foundation


struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=689bec6a00d70dd8ff4c5f3a8d174213&units=metric"
    var delegate : WeatherDelegate?
    let waetherWithLocationUrl = "https://api.openweathermap.org/data/2.5/weather?appid=689bec6a00d70dd8ff4c5f3a8d174213&units=metric"
    func fetchWearherWithName (cityName : String) {
        let URl = "\(weatherURL)&q=\(cityName)"
        performRequest(with: URl)
    }
    
    func fetchWearherWithLocation (lat : String,lon :String) {
        let URl = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: URl)
    }
    
    
    func performRequest (with url : String){
        print("url \(url)")
        //create url
        if let url = URL(string: url) {
            //create urlSession
            let session = URLSession(configuration: .default)
            //give the session a task
            let task = session.dataTask(with: url, completionHandler: { (json, response, error) in
                if error != nil {
                    delegate?.withError(error: error!)
                    return
                }
                if let safeJson = json {
                    if let weather = parseToWeatherData(safeJson) {
                        delegate?.updateWeather(self,weather: weather)
                    }
                }
            }
                                        
            )
            // start the task
            task.resume()
        }
    }
    
    
    func parseToWeatherData (_ weatherJson : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
           let decodedData = try decoder.decode(WeatherFromJson.self, from: weatherJson)
           let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let humidity = decodedData.main.humidity
            let feelsLike = decodedData.main.feels_like
            print("id \(id)")
            print( "name \(name)")
            print("temp \(temp)")
            print("humidity \(humidity)")
            print("feelsLike \(feelsLike)")
            let weather = WeatherModel(conditionId: id, cityName:name, tempreature: temp,feelsLike: feelsLike,humadity: humidity)
            return weather
            
        }catch {
            delegate?.withError(error: error)
            return nil
        }
    }

    
}
