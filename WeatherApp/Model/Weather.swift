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
}

struct Temperature: Decodable {
    let c: Int
    let f: Int
}

struct Wind: Decodable {
    let km: Int
    let mile: Int
}
/*
{"region":"London, UK",
 "currentConditions":
    {"dayhour":"Friday 10:00PM",
    "temp":{"c":13,"f":55},
    "precip":"2%",
    "humidity":"77%",
    "wind":{"km":6,"mile":4},
    "iconURL":"https://ssl.gstatic.com/onebox/weather/64/sunny.png",
    "comment":"Clear"},
 
 "next_days": [
 
 {
    "day":"Friday",
    "comment":"Clear with periodic clouds",
    "max_temp":{"c":22,"f":72},
    "min_temp":{"c":7,"f":45},
    "iconURL":"https://ssl.gstatic.com/onebox/weather/48/sunny_s_cloudy.png"
 },
 {"day":"Saturday","comment":"Sunny","max_temp":{"c":20,"f":68},"min_temp":{"c":7,"f":45},"iconURL":"https://ssl.gstatic.com/onebox/weather/48/sunny.png"},
 {"day":"Sunday","comment":"Partly cloudy","max_temp":{"c":19,"f":66},"min_temp":{"c":9,"f":48},"iconURL":"https://ssl.gstatic.com/onebox/weather/48/partly_cloudy.png"},
 {"day":"Monday","comment":"Cloudy","max_temp":{"c":17,"f":62},"min_temp":{"c":7,"f":45},"iconURL":"https://ssl.gstatic.com/onebox/weather/48/cloudy.png"},
 {"day":"Tuesday","comment":"Scattered showers","max_temp":{"c":14,"f":58},"min_temp":{"c":7,"f":44},"iconURL":"https://ssl.gstatic.com/onebox/weather/48/rain_s_cloudy.png"},
 {"day":"Wednesday","comment":"Partly cloudy","max_temp":{"c":14,"f":57},"min_temp":{"c":6,"f":43},"iconURL":"https://ssl.gstatic.com/onebox/weather/48/partly_cloudy.png"},
 {"day":"Thursday","comment":"Mostly cloudy","max_temp":{"c":17,"f":62},"min_temp":{"c":8,"f":47},"iconURL":"https://ssl.gstatic.com/onebox/weather/48/partly_cloudy.png"},
 {"day":"Friday","comment":"Scattered showers","max_temp":{"c":16,"f":60},"min_temp":{"c":8,"f":47},"iconURL":"https://ssl.gstatic.com/onebox/weather/48/rain_s_cloudy.png"}
 ],
 
 "contact_author":{"email":"communication.with.users@gmail.com",
 "auth_note":"Mail me for feature requests, improvement, bug, help, ect... Please tell me if you want me to provide any other free easy-to-use API services"},
 "data_source":"https://www.google.com/search?lr=lang_en&q=weather+in+london"}
 */
