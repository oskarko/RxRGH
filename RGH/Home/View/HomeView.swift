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

    @IBOutlet private weak var tableview: UITableView!

    private var router = HomeRouter()
    private var viewModel = HomeViewModel(managerServices: ManagerServices())
    private var disposeBag = DisposeBag()
    private var hotels = [Hotel]()
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

        viewModel.bind(view: self, router: router)

        getHotels()
    }

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

        searchBar.rx.text
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

    private func getHotels() {
        return viewModel.getListHotels()
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: { hotels in
                    self.hotels = hotels
                    self.getRatings()
                }, onError: { error in
                    print("Unknown error: " + error.localizedDescription)
                })
            .disposed(by: disposeBag)
    }

    private func getRatings() {
        return viewModel.getListRatings()
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: { ratings in
                    for (index, ratingHotel) in ratings.enumerated() {
                        self.hotels[index].rating = ratingHotel.rating
                    }
                    self.reloadTableview()
                }, onError: { error in
                    print("Unknown error: " + error.localizedDescription)
                })
            .disposed(by: disposeBag)
    }


    private func reloadTableview() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}

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

        cell.imageview.sd_setImage(with: URL(string: hotel.image.url),
                                   placeholderImage: UIImage(named: "hotel"))
        cell.distanceLbl.text =
            String(format: "%.2f", hotel.distance.miles) + " miles from downtown"
        cell.ratingview.image = UIImage(named: "\(hotel.rating!.bubbleRating)")
        cell.nameLbl.text = hotel.name

        return cell
    }
}

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

extension HomeView: UISearchControllerDelegate {
    func searchbarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableview()
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        reloadTableview()
    }
}
