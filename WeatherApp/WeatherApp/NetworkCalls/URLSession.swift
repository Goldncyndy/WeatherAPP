//
//  URLSession.swift
//  WeatherApp
//
//  Created by Decagon on 09/08/2021.
//

import UIKit

protocol WeatherParams {
  var city: String { get }
  var apiKey: String { get }
//  var days: Int { get }
}

extension WeatherParams {
  var city: String { "Lagos" }
  var apiKey: String { "2179fde0dfacd0993966fc4fe50418bf" }
  //var days: Int { 20 }
}

enum WeatherRequestType: WeatherParams {
  case current
  case forecast
  
  var description: String {
    switch self {
    case .current:
      return "weather/?q=\(city)&appid=\(apiKey)&units=metric"
    case .forecast:
      return "forecast/?q=\(city)&appid=\(apiKey)&units=metric"
    }
  }
}

// "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&cnt=\(days)&appid=\(apiKey)&units=imperial"


class DataLoader: WeatherParams {
  
  func getCurrentWeather(with url: URL?, completionHandler: @escaping (CurrentWeatherData) -> Void) {
    
    guard let url = url else { return }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: url) { data, response, error in
      guard error == nil else {
        print("Error: \(String(describing: error?.localizedDescription)) occurred")
        return
      }
      guard let data = data else {
        print("Error: No data")
        return
      }
      
      let decoder = JSONDecoder()
      
      do {
        let JSONResult = try decoder.decode(CurrentWeatherData.self, from: data)
        completionHandler(JSONResult)
      } catch {
        print("Error: \(error)")
      }
    }
    task.resume()
    
  }
  
  func getForecastWeather(with url: URL?, completionHandler: @escaping (ForecastWeatherData) -> Void) {
    
    guard let url = url else {
      return
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: url) { data, response, error in
      guard error == nil else {
        print("Error: \(String(describing: error?.localizedDescription)) occurred")
        return
      }
      guard let data = data else {
        print("Error: No data")
        return
      }
      
      let decoder = JSONDecoder()
      
      do {
        let JSONResult = try decoder.decode(ForecastWeatherData.self, from: data)
        completionHandler(JSONResult)
      } catch {
        print("Error: \(error.localizedDescription)")
      }
    }
    task.resume()
  }
  
}
