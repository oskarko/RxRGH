//
//  HomeRouter.swift
//  RGH
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//

import Foundation
import UIKit

class HomeRouter {
    var viewController: UIViewController {
        return makeViewController()
    }

    private var sourceView: UIViewController?

    private func makeViewController() -> UIViewController {
        let viewController = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return viewController
    }

    func setSourceView(_ sourceView: UIViewController?) {
        guard let sourceView = sourceView else { fatalError("Fatal error") }

        self.sourceView = sourceView
    }
}
