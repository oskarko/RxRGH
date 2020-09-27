//
//  ManagerServices.swift
//  RGH
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation
import RxSwift

class ManagerServices {

    func getListHotels() -> Observable <[Hotel]> {
        return Observable.create { observer in

            let session = URLSession.shared
            var request = URLRequest(url:
                                        URL(string: Constants.URL.main
                                                + Constants.Endpoints.urlListHotels)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            session.dataTask(with: request) { (data, response, error) in

                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      error == nil else { return }

                if response.statusCode == 200 {
                    do {
                        let hotels = try JSONDecoder().decode(Hotels.self, from: data)
                        observer.onNext(hotels.listOfHotels)
                    } catch let error {
                        observer.onError(error)
                        print("Unknown error in call: " + "\(error)")
                    }
                }

                observer.onCompleted()
            }.resume()

            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }

    func getListRatings() -> Observable <[RatingHotel]> {
        return Observable.create { observer in

            let session = URLSession.shared
            var request = URLRequest(url:
                                        URL(string: Constants.URL.main
                                                + Constants.Endpoints.urlListRatings)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            session.dataTask(with: request) { (data, response, error) in

                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      error == nil else { return }

                if response.statusCode == 200 {
                    do {
                        let ratings = try JSONDecoder().decode(Ratings.self, from: data)
                        observer.onNext(ratings.listOfRatings)
                    } catch let error {
                        observer.onError(error)
                        print("Unknown error in call: " + "\(error)")
                    }
                }

                observer.onCompleted()
            }.resume()

            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
}
