//
//  Ratings.swift
//  RGH
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//

import Foundation

struct Ratings: Decodable {
    let listOfRatings: [RatingHotel]

    enum CodingKeys: String, CodingKey {
        case listOfRatings = "hotels"
    }
}

struct RatingHotel: Decodable {
    let rating: Rating
    let code: String
}

struct Rating: Decodable {
    let bubbleRating: Float
    let reviewCount: Int
}
