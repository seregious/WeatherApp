//
//  ViewController.swift
//  WeatherApp
//
//  Created by Сергей Иванчихин on 16.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loadscreen: UIView!
    @IBOutlet weak var cloudThree: UIImageView!
    @IBOutlet weak var cloudOne: UIImageView!
    @IBOutlet weak var cloudFour: UIImageView!
    @IBOutlet weak var cloudTwo: UIImageView!
    @IBOutlet weak var sunImage: UIImageView!
    
    
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    private let url = "https://weatherdbi.herokuapp.com/data/weather/london"
    private var weather: Weather?

    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadScreen()
        cloudsAnimation()
        sunRotation()
        self.view.layer.insertSublayer(gradientLayer(), at:0)
        
        tableView.rowHeight = 60
        tableView.allowsSelection = false
        fetchData()
        currentWeatherLabel.textColor = .white
    }
    
    private func fetchImage(url: String) -> UIImage? {
        guard let data = NetworkManager.shared.fetchImage(from: url) else {return nil}
        return UIImage(data: data)
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchData(url: url) { weather in
            self.weather = weather
            
            self.title = weather.title
            self.currentWeatherLabel.text = weather.description
            self.tableView.reloadData()
            self.currentWeatherImage.image = self.fetchImage(url: weather.currentConditions.iconURL)
            self.setShadow(for: self.currentWeatherImage)
            self.setOpacity()
        }
    }
    
    private func setImage(from object: NextDay) -> UIImage? {
        guard let image = NetworkManager.shared.fetchImage(from: object.iconURL) else { return nil }
        return UIImage(data: image)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weather?.nextDays.count ?? 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayID", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let data = weather?.nextDays[indexPath.row]
        
        content.text = data?.day
        content.textProperties.color = .white
        
        content.secondaryText = data?.description
        content.secondaryTextProperties.color = .white
        
        cell.backgroundColor = .clear
        cell.contentConfiguration = content
        //content.image = setImage(from: data?.iconURL)
        return cell
    }
}

extension ViewController {
    
    private func setLoadScreen() {
        self.navigationController?.isNavigationBarHidden = true
        self.loadscreen.layer.insertSublayer(gradientLayer(), at: 0)
        setColor(for: cloudOne)
        setColor(for: cloudTwo)
        setColor(for: cloudThree)
        setColor(for: cloudFour)
        setColor(for: sunImage, symbol: "sun.max.fill", color: .yellow)
        
    }
    
    private func setColor(for imageView: UIImageView, symbol: String = "cloud.fill", color: UIColor = .white) {
        imageView.image = UIImage(systemName: symbol)?.withTintColor(color, renderingMode: .alwaysOriginal)
        setShadow(for: imageView)
    }
    
    private func setShadow(for imageView: UIView) {
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 3.0
        imageView.layer.shadowOpacity = 1.0
        imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageView.layer.masksToBounds = false
    }

    func cloudsAnimation() {
        let clouds = [cloudOne, cloudTwo, cloudThree, cloudFour]
        for cloud in clouds {
        UIView.animate(
            withDuration: 1,
            delay: Double.random(in: 0...0.4),
            options: [.autoreverse, .repeat]) {
                cloud?.frame.origin.y -= 15
            }
        }
    }
    
    func sunRotation() {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [.autoreverse, .repeat]) {
                self.sunImage.transform = CGAffineTransform(rotationAngle: .pi/2)
            }
    }
    
    func setOpacity() {
        UIView.animate(
            withDuration: 0.7,
            delay: 0) {
                self.loadscreen.layer.opacity = 0
                self.cloudThree.layer.opacity = 0
                self.cloudOne.layer.opacity = 0
                self.cloudFour.layer.opacity = 0
                self.cloudTwo.layer.opacity = 0
                self.sunImage.layer.opacity = 0
                self.navigationController?.isNavigationBarHidden = false
            }
    }
    
    func gradientLayer() -> CAGradientLayer {
        let colorTop =  UIColor.tintColor.cgColor
        let colorBottom = UIColor.systemCyan.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.7]
        gradientLayer.frame = self.view.bounds
        
        return gradientLayer
    }
}

