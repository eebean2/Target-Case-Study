//
//  DetailCoordinator.swift
//  ProductViewer
//
//  Created by Erik Bean on 4/17/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Foundation
import Tempo

final class DetailCoordinator: TempoCoordinator {
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: DetailViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    let dispatcher = Dispatcher()
    
    lazy var viewController: DetailController = {
        return DetailController.viewControllerFor(coordinator: self)
    }()
    
    required init() {
        viewState = DetailViewState(items: [])
        updateState()
        registerListeners()
    }
    
    fileprivate func registerListeners() {
        // Unneeded at the current momenet
    }
    
    func updateState() {
        if let deal = viewController.deal {
            viewState.items = [DetailItemViewState(deal: deal)]
        } else {
            viewState.items = []
        }
    }
}
