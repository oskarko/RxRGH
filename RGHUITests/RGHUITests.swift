//
//  RGHUITests.swift
//  RGHUITests
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import XCTest

class RGHUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testUI() {

        let app = XCUIApplication()
        app.launch()
        let tables = app.tables

        XCTAssert(tables["tableview"].exists)
        XCTAssertEqual(tables["tableview"].cells.count, 6)

        tables.searchFields["Find an hotel"].tap()

        let mKey = app/*@START_MENU_TOKEN@*/.keys["M"]/*[[".keyboards.keys[\"M\"]",".keys[\"M\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()

        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"buscar\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        XCTAssertEqual(tables["tableview"].cells.count, 1)

        tables/*@START_MENU_TOKEN@*/.cells.containing(.image, identifier:"pin").element/*[[".cells.containing(.image, identifier:\"rating\").element",".cells.containing(.staticText, identifier:\"Park Plaza Wallstreet Berlin Mitte\").element",".cells.containing(.staticText, identifier:\"0.60 miles from downtown\").element",".cells.containing(.image, identifier:\"pin\").element"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Cancel"].tap()

        XCTAssertEqual(tables["tableview"].cells.count, 6)
    }
}
