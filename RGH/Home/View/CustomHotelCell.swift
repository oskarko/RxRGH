//
//  CustomHotelCell.swift
//  RGH
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import SDWebImage
import UIKit

class CustomHotelCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var ratingview: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!

    func configure(with hotel: Hotel, ratingHotel: RatingHotel?) {
        nameLbl.text = hotel.name
        distanceLbl.text = String(format: "%.2f", hotel.distance.miles) + " miles from downtown"

        imageview.sd_setImage(with: URL(string: hotel.image.url),
                                   placeholderImage: UIImage(named: "hotel"))

        // If we don't have a rating hotel, we hide the imageview.
        if let ratingHotel = ratingHotel {
            ratingview.image = UIImage(named: "\(ratingHotel.rating.bubbleRating)")
        }
        ratingview.isHidden = ratingHotel == nil
    }
}
