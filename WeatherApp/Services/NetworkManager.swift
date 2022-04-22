//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Сергей Иванчихин on 16.04.2022.
//

import Foundation
import UIKit
import Alamofire



class NetworkManager {
    
    static let shared = NetworkManager()
    
    let url = "https://weatherdbi.herokuapp.com/data/weather/london"

    //MARK: - Download with Alamofire
    func fetchWithAlamofire(_ completion: @escaping (Weather) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let result = Weather.getData(from: value) else { return }
                    completion(result)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchDataAlamofire(url: String, completion: @escaping (Data) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    //MARK: - Download with Result
    
    
    //MARK: - Default download
    func fetchData(with completion: @escaping(Weather) -> ()) {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                
                print(error ?? "unknown description")
                return}
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weather = try decoder.decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchImage(from url: String) -> Data? {
        guard let imageUrl = URL(string: url) else {return nil}
        return try? Data(contentsOf: imageUrl)
    }
    
    private init() {}
}


