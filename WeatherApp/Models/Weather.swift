//
//  Weather.swift
//  WeatherApp
//
//  Created by Сергей Иванчихин on 16.04.2022.
//

import Foundation

struct Weather: Decodable {
    let region: String
    let currentConditions: Today
    let next_days: [NextDay]
    
    var description: String {
        """
         \(region)
         \(currentConditions.dayhour)
         Precip: \(currentConditions.precip)
         Humidity: \(currentConditions.humidity)
         Wind: \(currentConditions.wind.km) km/h
         """
    }
    
    var title: String {
        "\(currentConditions.comment), \(currentConditions.temp.c)°"
    }
}

struct Today: Decodable {
    let dayhour: String
    let temp: Temperature
    let precip: String
    let humidity: String
    let wind: Wind
    let iconURL: String
    let comment: String
}

struct NextDay: Decodable {
    let day: String
    let comment: String
    let max_temp: Temperature
    let min_temp: Temperature
    let iconURL : String
    
    var description: String {
        "\(comment), \(min_temp.c)° - \(max_temp.c)°"
    }
}

struct Temperature: Decodable {
    let c: Int
    let f: Int
}

struct Wind: Decodable {
    let km: Int
    let mile: Int
}
