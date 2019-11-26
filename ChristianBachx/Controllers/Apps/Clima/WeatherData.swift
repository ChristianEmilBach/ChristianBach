//
//  WeatherData.swift
//  ChristianBach
//
//  Created by Christian Emil Bach on 21/11/2019.
//  Copyright © 2019 Christian Emil Bach. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
}

struct Sys: Decodable {
    let country: String
}
