//
//  CellClass.swift
//  WeatherApp
//
//  Created by Сергей Иванчихин on 19.04.2022.
//

import UIKit

class nextDaysCell: UICollectionViewCell {
    
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    let url = NetworkManager.shared.url
    
    func setCell(with data: NextDay) {
        dayLabel.text = data.day
        commentLabel.text = data.description
        
        DispatchQueue.global().async {
            guard let url = URL(string: data.iconURL ) else {return}
            guard let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.imageWeather.image = UIImage(data: imageData)
                self.setShadow(for: self.imageWeather)
            }
        }
        
    }
    
    private func setShadow(for imageView: UIView) {
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 3.0
        imageView.layer.shadowOpacity = 1.0
        imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageView.layer.masksToBounds = false
    }
}
