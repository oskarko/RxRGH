//
//  Hotels.swift
//  RGH
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//

import Foundation

struct Hotels: Decodable {
    let listOfHotels: [Hotel]

    enum CodingKeys: String, CodingKey {
        case listOfHotels = "hotels"
    }
}

struct Hotel: Decodable {
    let code: String
    let description: Description
    let distance: Distance
    let status: Status
    let theatre: String
    let name: String
    let image: Image
    let address: String
    let services: [Service]
    var rating: Rating?

    enum CodingKeys: String, CodingKey {
        case code
        case description
        case distance
        case status = "hotelStatus"
        case theatre
        case name
        case image
        case address
        case services
        case rating
    }
}

struct Distance: Decodable {
    let miles: Double
    let km: Double
}

struct Status: Decodable {
    let code: String
    let name: String
}

struct Description: Decodable {
    let title: String
    let shortDescription: String
}

struct Image: Decodable {
    let altText: String
    let url: String
    let width: Int
    let height: Int
}

struct Service: Decodable {
    let code: String
    let name: String
}
