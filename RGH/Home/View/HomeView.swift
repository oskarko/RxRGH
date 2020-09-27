//
//  HomeView.swift
//  RGH
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class HomeView: UIViewController {

    // MARK: - Properties

    @IBOutlet private weak var tableview: UITableView!

    private var router = HomeRouter()
    private var viewModel = HomeViewModel(managerServices: ManagerServices())
    private var disposeBag = DisposeBag()
    private var hotels: Observable<[Hotel]>!
    private var ratings = [RatingHotel]()
    private var originalHotels = [Hotel]()

    private var source = PublishSubject<[Hotel]>()

    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .default
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Find an hotel"

        return controller
    })()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true

        configureTableview()
        manageSearchBarController()
        setUpRx()

        viewModel.bind(view: self, router: router)

        getData()
    }

    // MARK: - API

    private func getData() {
        return Observable.zip(viewModel.getListHotels(), viewModel.getListRatings()) { ($0, $1) }
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: { hotels, ratings in
                    self.originalHotels = hotels
                    self.ratings = ratings
                    self.source.onNext(hotels)
                }, onError: { error in
                    print("Unknown error: " + error.localizedDescription)
                })
            .disposed(by: disposeBag)
    }

    // MARK: - Helpers

    private func configureTableview() {
        tableview.contentInsetAdjustmentBehavior = .never
        tableview.tableFooterView = UIView()
        tableview.accessibilityIdentifier = "tableview"
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "CustomHotelCell", bundle: nil),
                           forCellReuseIdentifier: "CustomHotelCell")
    }

    private func manageSearchBarController() {
        let searchBar = searchController.searchBar
        searchController.delegate = self
        tableview.tableHeaderView = searchBar
        tableview.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
    }

    private func setUpRx() {
        hotels = source.asObservable()

        searchController.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { (result) in
                let filteredHotels = self.originalHotels.filter({ hotel in
                    return hotel.name.contains(result)
                })
                self.source.onNext(filteredHotels)
            })
            .disposed(by: disposeBag)

        tableview.dataSource = nil
        hotels.bind(to: tableview.rx.items(cellIdentifier: "CustomHotelCell",
                                           cellType: CustomHotelCell.self)) {
            index, hotel, cell in

            let ratedHotels = self.ratings.filter({ ratingHotel in
                return hotel.code == ratingHotel.code
            })

            cell.configure(with: hotel,
                           ratingHotel: ratedHotels.count > 0 ? ratedHotels[0] : nil)
        }
        .disposed(by: disposeBag)

        tableview.rx.modelSelected(Hotel.self).subscribe(onNext: {
            hotel in

            self.viewModel.makeDetailsView(hotel: hotel)
        })
        .disposed(by: disposeBag)
    }
}

// MARK: - UISearchControllerDelegate

extension HomeView: UISearchControllerDelegate {
    func searchbarCancelButtonClicked(_ searchBar: UISearchBar) {
        source.onNext(originalHotels)
        searchController.isActive = false
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            self.source.onNext(self.originalHotels)
        }
    }
}
