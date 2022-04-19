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
    
    
    
    @IBOutlet weak var todayCommentLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private var weather: Weather?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCloudsAndSun()
        setLoadingScreen()
        self.view.layer.insertSublayer(gradientLayer(), at:0)
                
        collectionView.allowsSelection = false
        fetchData()
        currentWeatherLabel.textColor = .white
    }
    
    private func fetchImage(url: String) -> UIImage? {
        guard let data = NetworkManager.shared.fetchImage(from: url) else {return nil}
        return UIImage(data: data)
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchData() { weather in
            self.weather = weather
            
            self.todayCommentLabel.text = weather.title
            self.currentWeatherLabel.text = weather.description
            
            self.currentWeatherImage.image = self.fetchImage(url: weather.currentConditions.iconURL)
            self.setShadow(for: self.currentWeatherImage)
            self.setOpacity()
            self.collectionView.reloadData()
        }
    }

}

//MARK: - CollectionView
extension ViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weather?.nextDays.count ?? 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayID", for: indexPath) as! nextDaysCell
        guard let data = weather?.nextDays[indexPath.row] else { return cell }
        cell.setCell(with: data)
        
        return cell
    }
}

//MARK: - Loadscreen
extension ViewController {
    
    private func setCloudsAndSun() {
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

    private func cloudsAnimation() {
        let clouds = [cloudOne, cloudTwo, cloudThree, cloudFour]
        for cloud in clouds {
        UIView.animate(
            withDuration: 0.7,
            delay: Double.random(in: 0...0.4),
            options: [.autoreverse, .repeat, .curveEaseInOut]) {
                cloud?.frame.origin.y -= CGFloat(Int.random(in: 10...20))
            }
        }
    }
    
    private func sunRotation() {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [.autoreverse, .repeat]) {
                self.sunImage.transform = CGAffineTransform(rotationAngle: .pi / 2)
            }
    }
    
    private func setOpacity() {
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
    
    private func gradientLayer() -> CAGradientLayer {
        let colorTop =  UIColor.tintColor.cgColor
        let colorBottom = UIColor.systemCyan.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.7]
        gradientLayer.frame = self.view.bounds
        
        return gradientLayer
    }
    
    private func setLoadingScreen() {
        setCloudsAndSun()
        cloudsAnimation()
        sunRotation()
    }
}
