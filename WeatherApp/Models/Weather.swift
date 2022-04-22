//
//  Weather.swift
//  WeatherApp
//
//  Created by Сергей Иванчихин on 16.04.2022.
//

import Foundation

struct Weather: Codable {
    let region: String
    let currentConditions: Today
    let nextDays: [NextDay]
    
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
    
    init (value: [String : Any]) {
        region = value["region"] as? String ?? ""
        
        let currentConditionsDict = value["currentConditions"] as? [String : Any] ?? [:]
        currentConditions = Today(value: currentConditionsDict)
        
        let nextDaysArray = value["next_days"] as? [[String : Any]] ?? [[:]]
        nextDays = nextDaysArray.compactMap {NextDay(value: $0)}
    }
    
    static func getData(from value: Any) -> Weather? {
        let data = value as? [String : Any] ?? [:]
        return Weather(value: data)
    }
}

struct Today: Codable {
    let dayhour: String
    let temp: Temperature
    let precip: String
    let humidity: String
    let wind: Wind
    let iconURL: String
    let comment: String
    
    init(value: [String : Any]) {
        dayhour = value ["dayhour"] as? String ?? ""
        
        let tempDict = value["temp"] as? [String : Int] ?? [:]
        temp = Temperature(value: tempDict)
        
        precip = value["precip"] as? String ?? ""
        humidity = value["humidity"] as? String ?? ""
        
        let windDict = value["wind"] as? [String : Int] ?? [:]
        wind = Wind(value: windDict)
        
        iconURL = value["iconURL"] as? String ?? ""
        comment = value["comment"] as? String ?? ""
    }
}

struct NextDay: Codable {
    let day: String
    let comment: String
    let maxTemp: Temperature
    let minTemp: Temperature
    let iconURL : String
    
    var description: String {
        "\(comment), \(minTemp.c)° - \(maxTemp.c)°"
    }
    
    init(value: [String : Any]) {
        day = value["day"] as? String ?? ""
        comment = value["comment"] as? String ?? ""
        
        let maxTempDict = value["max_temp"] as? [String : Int] ?? [:]
        maxTemp = Temperature(value: maxTempDict)
        
        let minTempDict = value["min_temp"] as? [String : Int] ?? [:]
        minTemp = Temperature(value: minTempDict)
        
        iconURL = value["iconURL"] as? String ?? ""
    }
}

struct Temperature: Codable {
    let c: Int
    let f: Int
    
    init(value: [String : Int]) {
        c = value["c"] ?? 0
        f = value["f"] ?? 0
    }
}

struct Wind: Codable {
    let km: Int
    let mile: Int
    
    init(value: [String : Int]) {
        km = value["km"] ?? 0
        mile = value["mile"] ?? 0
    }
}
