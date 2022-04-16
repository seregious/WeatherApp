//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Сергей Иванчихин on 16.04.2022.
//

import Foundation
import UIKit



class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(url: String, with completion: @escaping(Weather) -> ()) {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "unknown description")
                return}
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringUrl = url else {return nil}
        guard let imageUrl = URL(string: stringUrl) else {return nil}
        return  try? Data(contentsOf: imageUrl)
    }
    
    private init() {}
}


