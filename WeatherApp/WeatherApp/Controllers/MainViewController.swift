//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Decagon on 08/08/2021.
//

import UIKit

class MainViewController: UIViewController {
  
  
  @IBOutlet weak var bigCurrentTemperatureLabel: UILabel!
  @IBOutlet weak var weatherDescriptionLabel: UILabel!
  @IBOutlet weak var minimumTemperatureLabel: UILabel!
  @IBOutlet weak var currentTemperatureLabel: UILabel!
  
  @IBOutlet weak var maximumTemperatureLabel: UILabel!
  
  @IBOutlet weak var tuesdayTemperatureLabel: UILabel!
  
  @IBOutlet weak var wednesdayTemperatureLabel: UILabel!
  
  @IBOutlet weak var thursdayTemperatureLabel: UILabel!
  
  @IBOutlet weak var fridayTemperatureLabel: UILabel!
  
  @IBOutlet weak var saturdayTemperatureLabel: UILabel!
  
  @IBOutlet weak var tuesdayIconImage: UIImageView!
  
  @IBOutlet weak var wednesdayIconLabel: UIImageView!
  
  @IBOutlet weak var thursdayIconLabel: UIImageView!
  
  @IBOutlet weak var fridayIconLabel: UIImageView!
  
  @IBOutlet weak var saturdayIconLabel: UIImageView!
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  
  @IBOutlet weak var backgroundView: UIView!
  
  @IBOutlet weak var firstDayLabel: UILabel!
  
  @IBOutlet weak var secondDayLabel: UILabel!
  
  @IBOutlet weak var fourthDayLabel: UILabel!
  
  @IBOutlet weak var thirdDayLabel: UILabel!
  
  @IBOutlet weak var fifthDayLabel: UILabel!
  
  var dataLoader = DataLoader()
  
  let currentURL = URL(string: "https://api.openweathermap.org/data/2.5/\(WeatherRequestType.current.description)")
  let forecastURL = URL(string: "https://api.openweathermap.org/data/2.5/\(WeatherRequestType.forecast.description)")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    makeForecastWeatherNetworkCall()
    makeCurrentWeatherNetworkCall()
    
  }
  
  private func makeCurrentWeatherNetworkCall() {
    DataLoader().getCurrentWeather(with: currentURL) { [weak self] currentWeatherData in
      //print(currentWeatherData)
      
      DispatchQueue.main.async {
        self?.weatherDescriptionLabel.text = String(currentWeatherData.weather[0].main)
        self?.minimumTemperatureLabel.text = String(Int(currentWeatherData.main.minTemp)) + "°"
        self?.maximumTemperatureLabel.text = String(Int(currentWeatherData.main.maxTemp)) + "°"
        self?.currentTemperatureLabel.text = String(Int(currentWeatherData.main.temp)) + "°"
        self?.bigCurrentTemperatureLabel.text = self?.currentTemperatureLabel.text
        
        
        let backgroundImage = String(currentWeatherData.weather[0].main)
        
        switch backgroundImage {
        
        case "Sunny":
          self?.backgroundImageView.image = UIImage(named: "forest_sunny")!
          self?.view.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7956655819, blue: 0.3490196078, alpha: 1)
          self?.backgroundView.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7956655819, blue: 0.3490196078, alpha: 1)
        case "Clouds":
          self?.backgroundImageView.image = UIImage(named: "forest_cloudy")!
          self?.view.backgroundColor = #colorLiteral(red: 0.3296013772, green: 0.442932874, blue: 0.4766924381, alpha: 1)
          self?.backgroundView.backgroundColor = #colorLiteral(red: 0.3296013772, green: 0.442932874, blue: 0.4766924381, alpha: 1)
        case "Rain":
          self?.backgroundImageView.image = UIImage(named: "forest_rainy")!
          self?.view.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
          self?.backgroundView.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        default:
          self?.backgroundImageView.image = UIImage(named: "forest_sunny")!
        }
      }
    }
  }
  
  
  private func makeForecastWeatherNetworkCall() {
    DataLoader().getForecastWeather(with: forecastURL) { [weak self] forecastWeatherData in
      //print(forecastWeatherData)
      
      DispatchQueue.main.async { [self] in
        self?.tuesdayTemperatureLabel.text = String(Int(forecastWeatherData.list[0].main.temp)) + "°"
        self?.wednesdayTemperatureLabel.text = String(Int(forecastWeatherData.list[1].main.temp)) + "°"
        self?.thursdayTemperatureLabel.text = String(Int(forecastWeatherData.list[2].main.temp)) + "°"
        self?.fridayTemperatureLabel.text = String(Int(forecastWeatherData.list[3].main.temp)) + "°"
        self?.saturdayTemperatureLabel.text = String(Int(forecastWeatherData.list[4].main.temp)) + "°"
        
        let iconSwitchDay1 = String(forecastWeatherData.list[0].weather[0].main)
        
        self?.firstDayLabel.text = self!.getDayForDate(Date(timeIntervalSince1970: Double((forecastWeatherData.list[0].dateText))))
        self?.secondDayLabel.text = self!.getDayForDate(Date(timeIntervalSince1970: Double((forecastWeatherData.list[8].dateText))))
        self?.thirdDayLabel.text = self!.getDayForDate(Date(timeIntervalSince1970: Double((forecastWeatherData.list[16].dateText))))
        self?.fourthDayLabel.text = self!.getDayForDate(Date(timeIntervalSince1970: Double((forecastWeatherData.list[24].dateText))))
        self?.fifthDayLabel.text = self!.getDayForDate(Date(timeIntervalSince1970: Double((forecastWeatherData.list[32].dateText))))
        
        switch iconSwitchDay1 {
        case "Clouds":
          self?.tuesdayIconImage.image = UIImage(named: "partlysunny")
        case "Rain":
          self?.tuesdayIconImage.image = UIImage(named: "rain")
        default:
          self?.tuesdayIconImage.image = UIImage(named: "clear")
        }
        
        let iconSwitchDay2 = String(forecastWeatherData.list[2].weather[0].main)
        
        switch iconSwitchDay2 {
        case "Clouds":
          self?.wednesdayIconLabel.image = UIImage(named: "partlysunny")
        case "Rain":
          self?.wednesdayIconLabel.image = UIImage(named: "rain")
        default:
          self?.wednesdayIconLabel.image = UIImage(named: "clear")
        }
        
        
        let iconSwitchDay3 = String(forecastWeatherData.list[3].weather[0].main)
        
        switch iconSwitchDay3 {
        case "Clouds":
          self?.thursdayIconLabel.image = UIImage(named: "partlysunny")
        case "Rain":
          self?.thursdayIconLabel.image = UIImage(named: "rain")
        default:
          self?.thursdayIconLabel.image = UIImage(named: "clear")
        }
        
        let iconSwitchDay4 = String(forecastWeatherData.list[4].weather[0].main)
        
        switch iconSwitchDay4 {
        case "Clouds":
          self?.fridayIconLabel.image = UIImage(named: "partlysunny")
        case "Rain":
          self?.fridayIconLabel.image = UIImage(named: "rain")
        default:
          self?.fridayIconLabel.image = UIImage(named: "clear")
        }
        
        let iconSwitchDay5 = String(forecastWeatherData.list[5].weather[0].main)
        
        switch iconSwitchDay5 {
        case "Clouds":
          self?.saturdayIconLabel.image = UIImage(named: "partlysunny")
        case "Rain":
          self?.saturdayIconLabel.image = UIImage(named: "rain")
        default:
          self?.saturdayIconLabel.image = UIImage(named: "clear")
        }
        
      }
      
    }
  }
  
  
  func getDayForDate(_ date: Date?)-> String {
    guard  let inputDate = date else {
      return  ""
    }
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return formatter.string(from: inputDate)
  }
}
