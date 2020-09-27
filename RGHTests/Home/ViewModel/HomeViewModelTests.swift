//
//  HomeViewModelTests.swift
//  RGHTests
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import XCTest
import RxSwift

class HomeViewModelTests: XCTestCase {

    // MARK: Test subject
    var viewModel : HomeViewModel!
    fileprivate var service : FakeManagerServices!

    override func setUp() {
        super.setUp()
        service = FakeManagerServices(fakeHotels: Utils.getListHotels(),
                                      fakeRatings: Utils.getListRatings())
        viewModel = HomeViewModel(managerServices: service)
    }

    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }

    func testGetListHotels() {
        _ = service.getListHotels().bind { sHotels in
            _ = self.viewModel.getListHotels().bind { vmHotels in

                XCTAssertEqual(sHotels.count, vmHotels.count)
                XCTAssertEqual(sHotels[0].name, vmHotels[0].name)
                XCTAssertEqual(sHotels[2].status.name, vmHotels[2].status.name)
            }
        }
    }

    func testGetListRating() {
        _ = service.getListRatings().bind { sRatings in
            _ = self.viewModel.getListRatings().bind { vmRatings in

                XCTAssertEqual(sRatings.count, vmRatings.count)
                XCTAssertEqual(sRatings[0].rating.reviewCount, vmRatings[0].rating.reviewCount)
                XCTAssertEqual(sRatings[2].code, vmRatings[2].code)
            }
        }
    }
}
