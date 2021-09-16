//
//  ForcastData.swift
//  WeatherApp
//
//  Created by Decagon on 09/08/2021.
//

import UIKit

// MARK: - WeatherForcast
struct ForecastWeatherData: Decodable {
  let list: [List]
}

struct List: Decodable {
  let main: Main
  let weather: [WeatherDetails]
  let dateText: Int
  
  enum CodingKeys: String, CodingKey {
    case main
    case weather
    case dateText = "dt"
  }
}

struct Main: Decodable {
  let temp: Float
  
  enum CodingKeys: String, CodingKey {
    case temp
  }
}

struct WeatherDetails: Decodable {
  let main: String
}
