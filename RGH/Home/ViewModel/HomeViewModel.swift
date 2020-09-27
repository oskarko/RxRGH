//
//  HomeViewModel.swift
//  RGH
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    private weak var view: HomeView?
    private var router: HomeRouter?
    private var managerServices: ManagerServices

    let title: String = "Hotels"

    init(managerServices: ManagerServices) {
        self.managerServices = managerServices
    }

    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router


        // Binding the router with the view
        self.router?.setSourceView(view)
    }

    func getListHotels() -> Observable<[Hotel]> {
        return managerServices.getListHotels()
    }

    func getListRatings() -> Observable<[RatingHotel]> {
        return managerServices.getListRatings()
    }

    func makeDetailsView(hotel: Hotel) {
        router?.navigateToDetailsView(hotel: hotel)
    }
}
