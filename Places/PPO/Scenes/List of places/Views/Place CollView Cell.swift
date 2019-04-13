//
//  Place cell.swift
//  PPO
//
//  Created by  9r4ik on 25/03/2019.
//  Copyright © 2019 9r4. All rights reserved.
//

import UIKit

class PlaceCollViewCell: UICollectionViewCell {
    @IBOutlet weak var _background_image: UIImageView!
    @IBOutlet weak var _place_name: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: "PlaceCell", bundle: nil) }
    
    override func awakeFromNib() {
        layer.shouldRasterize = true
    }
    
    func set(place: ListOfPlaces.PLaceModel) {
        _place_name.text = place.displayed_name
        _background_image.image = UIImage(named: place.url_string)
    }
    
}
