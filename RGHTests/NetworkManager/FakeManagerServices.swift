//
//  FakeManagerServices.swift
//  RGHTests
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//

import Foundation
import RxSwift

class FakeManagerServices: ManagerServices {

    private var fakeHotels:[Hotel]
    private var fakeRatings:[RatingHotel]

    // A new init method allowing to inject fake data
    init(fakeHotels: [Hotel], fakeRatings: [RatingHotel]) {
        self.fakeHotels = fakeHotels
        self.fakeRatings = fakeRatings
    }

    // An overridden method to return fake data
    override func getListHotels() -> Observable <[Hotel]>  {
        return Observable.just(self.fakeHotels)
    }

    override func getListRatings() -> Observable <[RatingHotel]> {
        return Observable.just(self.fakeRatings)
    }
}
