//
//  HomeView.swift
//  RGH
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//

import RxCocoa
import RxSwift
import SDWebImage
import UIKit

class HomeView: UIViewController {

    // MARK: - Properties

    @IBOutlet private weak var tableview: UITableView!

    private var router = HomeRouter()
    private var viewModel = HomeViewModel(managerServices: ManagerServices())
    private var disposeBag = DisposeBag()
    private var hotels = [Hotel]()
    private var ratings = [RatingHotel]()
    private var filteredHotels = [Hotel]()

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

        tableview.contentInsetAdjustmentBehavior = .never
        tableview.tableFooterView = UIView()
        tableview.delegate = self
        tableview.dataSource = self
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
                    self.hotels = hotels
                    self.ratings = ratings
                    self.reloadTableview()
                }, onError: { error in
                    print("Unknown error: " + error.localizedDescription)
                })
            .disposed(by: disposeBag)
    }

    // MARK: - Helpers

    private func configureTableview() {
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
        searchController.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { (result) in
                self.filteredHotels = self.hotels.filter({ hotel in
                    self.reloadTableview()
                    return hotel.name.contains(result)
                })
            })
            .disposed(by: disposeBag)
    }

    private func reloadTableview() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}

// MARK: - UISearchControllerDelegate

extension HomeView: UISearchControllerDelegate {
    func searchbarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableview()
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        reloadTableview()
    }
}

// MARK: - UITableViewDataSource

/* The best approach is creating an Observable array to bind it
 directly with the tableview and avoid all this boilerplate code
 such as UITableViewDataSource && UITableViewDelegate.*/
extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive && searchController.searchBar.text != "" ?
            filteredHotels.count : hotels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier:"CustomHotelCell") as! CustomHotelCell

        let hotel: Hotel = searchController.isActive && searchController.searchBar.text != "" ?
            filteredHotels[indexPath.row] : hotels[indexPath.row]

        cell.nameLbl.text = hotel.name
        cell.imageview.sd_setImage(with: URL(string: hotel.image.url),
                                   placeholderImage: UIImage(named: "hotel"))
        cell.distanceLbl.text =
            String(format: "%.2f", hotel.distance.miles) + " miles from downtown"

        let ratedHotels = self.ratings.filter({ ratingHotel in
            return hotel.code == ratingHotel.code
        })
        if ratedHotels.count > 0 {
            cell.ratingview.image = UIImage(named: "\(ratedHotels[0].rating.bubbleRating)")
        }
        cell.ratingview.isHidden = ratedHotels.count == 0

        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotel: Hotel = searchController.isActive && searchController.searchBar.text != "" ?
            filteredHotels[indexPath.row] : hotels[indexPath.row]

        viewModel.makeDetailsView(hotel: hotel)
    }
}
