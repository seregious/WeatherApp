//
//  ViewController.swift
//  WeatherApp
//
//  Created by Сергей Иванчихин on 16.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    private let url = "https://weatherdbi.herokuapp.com/data/weather/london"
    private var weather: Weather?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        fetchData()
    }
    
    private func fetchImage(url: String) -> UIImage? {
        guard let data = NetworkManager.shared.fetchImage(from: url) else {return nil}
        return UIImage(data: data)
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchData(url: url) { weather in
            self.weather = weather
            self.tableView.reloadData()
            self.title = weather.title
            self.currentWeatherLabel.text = weather.description
            self.currentWeatherImage.image = self.fetchImage(url: weather.currentConditions.iconURL)
            
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weather?.next_days.count ?? 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayID", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let data = weather?.next_days[indexPath.row]
        content.text = data?.day
        content.secondaryText = data?.description
        cell.contentConfiguration = content
        DispatchQueue.main.async {
        //content.image = self.fetchImage(url: data.iconURL)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
