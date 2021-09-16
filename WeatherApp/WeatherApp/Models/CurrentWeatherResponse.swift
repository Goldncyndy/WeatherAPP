//
//  CurrentWeatherResponse.swift
//  WeatherApp
//
//  Created by Decagon on 10/08/2021.
//

import Foundation

struct CurrentWeatherData: Decodable {
  let weather: [CurrentWeatherDetails]
  let main: CurrentTempDetails
}

struct CurrentWeatherDetails: Decodable {
  let main: String
}

struct CurrentTempDetails: Decodable {
  var temp: Double
  let minTemp: Double
  let maxTemp: Double
  
  enum CodingKeys: String, CodingKey {
    case temp
    case minTemp = "temp_min"
    case maxTemp = "temp_max"
  }
}
