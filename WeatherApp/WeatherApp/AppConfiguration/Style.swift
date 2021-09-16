//
//  Style.swift
//  WeatherApp
//
//  Created by Decagon on 09/08/2021.
//

import UIKit

enum AppGraphics {
  
  enum Background {
    case sunny
    case cloudy
    case rainy
    
    var image: UIImage {
      switch self {
      case .sunny:
        return UIImage(named: "forest_sunny")!
      case .cloudy:
        return UIImage(named: "forest_cloudy")!
      case .rainy:
        return UIImage(named: "forest_rainy")!
      }
    }
  }
  
  enum icons {
    case clear
    case partlysunny
    case rain
    
    var image: UIImage {
      switch self {
      case .clear:
        return UIImage(named: "Clear")!
      case .partlysunny:
        return UIImage(named: "partlySunny")!
      case .rain:
        return UIImage(named: "rain")!
      }
    }
  }
}
