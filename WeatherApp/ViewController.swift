//
//  ViewController.swift
//  WeatherApp
//
//  Created by Сергей Иванчихин on 16.04.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }


}

extension ViewController {
    private func fetch() {
        guard let url = URL(string: "https://weatherdbi.herokuapp.com/data/weather/london") else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "unknown description")
                return}
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                print (weather)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

