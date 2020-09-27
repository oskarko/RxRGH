//
//  Utils.swift
//  RGHTests
//
//  Created by Oscar Rodriguez Garrucho on 27/09/2020.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Swift

class Utils {

    static func getListHotels() -> [Hotel] {
        let testHotel1 = Hotel(code: "testCode1",
                               description: Description(title: "titleDescription1",
                                                        shortDescription: "short1"),
                               distance: Distance(miles: 0.111,
                                                  km: 0.111),
                               status: Status(code: "codeStatus1",
                                              name: "nameStatus1"),
                               theatre: "test1",
                               name: "name1",
                               image: Image(altText: "alt1",
                                            url: "",
                                            width: 1,
                                            height: 1),
                               address: "address1",
                               services: [])
        let testHotel2 = Hotel(code: "testCode2",
                               description: Description(title: "titleDescription2",
                                                        shortDescription: "short2"),
                               distance: Distance(miles: 0.222,
                                                  km: 0.222),
                               status: Status(code: "codeStatus2",
                                              name: "nameStatus2"),
                               theatre: "test2",
                               name: "name2",
                               image: Image(altText: "alt2",
                                            url: "",
                                            width: 2,
                                            height: 2),
                               address: "address2",
                               services: [])
        let testHotel3 = Hotel(code: "testCode3",
                               description: Description(title: "titleDescription3",
                                                        shortDescription: "short3"),
                               distance: Distance(miles: 0.333,
                                                  km: 0.333),
                               status: Status(code: "codeStatus3",
                                              name: "nameStatus3"),
                               theatre: "test3",
                               name: "name3",
                               image: Image(altText: "alt3",
                                            url: "",
                                            width: 3,
                                            height: 3),
                               address: "address3",
                               services: [])
        let testHotel4 = Hotel(code: "testCode4",
                               description: Description(title: "titleDescription4",
                                                        shortDescription: "short4"),
                               distance: Distance(miles: 0.444,
                                                  km: 0.444),
                               status: Status(code: "codeStatus4",
                                              name: "nameStatus4"),
                               theatre: "test4",
                               name: "name4",
                               image: Image(altText: "alt4",
                                            url: "",
                                            width: 4,
                                            height: 4),
                               address: "address4",
                               services: [])

        return [testHotel1, testHotel2, testHotel3, testHotel4]
    }

    static func getListRatings() -> [RatingHotel] {
        let ratingHotel = RatingHotel(rating: Rating(bubbleRating: 1.0,
                                                     reviewCount: 1),
                                      code: "code1")
        let ratingHote2 = RatingHotel(rating: Rating(bubbleRating: 2.0,
                                                     reviewCount: 2),
                                      code: "code2")
        let ratingHote3 = RatingHotel(rating: Rating(bubbleRating: 3.0,
                                                     reviewCount: 3),
                                      code: "code3")
        let ratingHote4 = RatingHotel(rating: Rating(bubbleRating: 4.0,
                                                     reviewCount: 4),
                                      code: "code4")

        return [ratingHotel, ratingHote2, ratingHote3, ratingHote4]
    }
}
