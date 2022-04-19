//
//  CellClass.swift
//  WeatherApp
//
//  Created by Сергей Иванчихин on 19.04.2022.
//

import UIKit

class nextDaysCell: UITableViewCell {
    
    let url = NetworkManager.shared.url
    
    func setCell(with data: NextDay, cell: UITableViewCell) {
        var content = cell.defaultContentConfiguration()
        content.text = data.day
        content.textProperties.color = .white
        
        content.secondaryText = data.description
        content.secondaryTextProperties.color = .white
        
        cell.backgroundColor = .clear
        cell.contentConfiguration = content
        
        DispatchQueue.global().async {
            guard let url = URL(string: data.iconURL ) else {return}
            guard let imageData = try? Data(contentsOf: url) else {return}
            
            DispatchQueue.main.async {
                content.image = UIImage(data: imageData)
            }
        }
        
    }
}
