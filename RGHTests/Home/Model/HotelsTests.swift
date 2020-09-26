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
        let testHotel1 = Hotel(code: "testCode1",
                               description: Description(title: "titleDescription1",
                                                        shortDescription: "short1"),
                               distance: Distance(miles: 0.111, km: 0.111),
                               status: Status(code: "codeStatus1", name: "nameStatus1"),
                               theatre: "test1",
                               name: "name1",
                               image: Image(altText: "alt1", url: "", width: 1, height: 1),
                               address: "address1",
                               services: [])
        let testHotel2 = Hotel(code: "testCode2",
                               description: Description(title: "titleDescription2",
                                                        shortDescription: "short2"),
                               distance: Distance(miles: 0.222, km: 0.222),
                               status: Status(code: "codeStatus2", name: "nameStatus2"),
                               theatre: "test2",
                               name: "name2",
                               image: Image(altText: "alt2", url: "", width: 2, height: 2),
                               address: "address2",
                               services: [])
        let testHotel3 = Hotel(code: "testCode3",
                               description: Description(title: "titleDescription3",
                                                        shortDescription: "short3"),
                               distance: Distance(miles: 0.333, km: 0.333),
                               status: Status(code: "codeStatus3", name: "nameStatus3"),
                               theatre: "test3",
                               name: "name3",
                               image: Image(altText: "alt3", url: "", width: 3, height: 3),
                               address: "address3",
                               services: [])
        let testHotel4 = Hotel(code: "testCode4",
                               description: Description(title: "titleDescription4",
                                                        shortDescription: "short4"),
                               distance: Distance(miles: 0.444, km: 0.444),
                               status: Status(code: "codeStatus4", name: "nameStatus4"),
                               theatre: "test4",
                               name: "name4",
                               image: Image(altText: "alt4", url: "", width: 4, height: 4),
                               address: "address4",
                               services: [])
        model = Hotels(listOfHotels: [testHotel1, testHotel2, testHotel3, testHotel4])
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
