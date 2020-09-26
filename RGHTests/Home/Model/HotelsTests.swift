//
//  HotelsTests.swift
//  RGHTests
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//

import XCTest

class HotelsTests: XCTestCase {

    var model: Hotels!

    override func setUp() {
        super.setUp()
        model = Hotels(listOfHotels: Utils.getListHotels())
    }

    override func tearDown() {
        model = nil
        super.tearDown()
    }

    func testModel() {
        // expected hotels count in model
        XCTAssertEqual(model.listOfHotels.count, 4,
                       "Expected 4 in model")

        // expected name in first hotel model
        XCTAssertEqual(model.listOfHotels[0].name, "name1",
                       "Expected name in model")

        // expected description title in first hotel model
        XCTAssertEqual(model.listOfHotels[0].description.title, "titleDescription1",
                       "Expected description in model")

        // expected distance in milles in second hotel model
        XCTAssertEqual(model.listOfHotels[1].distance.miles, 0.222,
                       "Expected distance in model")

        // expected status name in second hotel model
        XCTAssertEqual(model.listOfHotels[1].status.name, "nameStatus2",
                       "Expected status name in model")

        // expected theatre in third hotel model
        XCTAssertEqual(model.listOfHotels[2].theatre, "test3",
                       "Expected theatre in model")

        // expected code in first third model
        XCTAssertEqual(model.listOfHotels[2].code, "testCode3",
                       "Expected code in model")

        // expected image alt in fourth hotel model
        XCTAssertEqual(model.listOfHotels[3].image.altText, "alt4",
                       "Expected image alt in model")

        // expected address in fourth hotel model
        XCTAssertEqual(model.listOfHotels[3].address, "address4",
                       "Expected address in model")
    }
}
