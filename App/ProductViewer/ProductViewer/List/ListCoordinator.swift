//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo

/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: ListViewState {
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
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])
        updateState()
        registerListeners()
        
    }
    
    // MARK: ListCoordinator
    
    fileprivate func registerListeners() {
        // Listening for when users press the screen on an item
        dispatcher.addObserver(ListItemPressed.self) { event in
            guard let navi = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else { return }
            let dc = DetailCoordinator()
            dc.viewController.deal = event.deal
            dc.updateState()
            dc.viewController.modalPresentationStyle = .fullScreen
            navi.pushViewController(dc.viewController, animated: true)
        }
        
        // Listening to our Deals API to update our state after downloading
        // an updated list
        dispatcher.addObserver(ListItemUpdated.self) { [weak self] _ in
            DispatchQueue.main.async {
                self?.updateState()
            }
        }
        
        // Listening to our image downloader for when product images are ready
        // to update the state after being downloaded
        dispatcher.addObserver(ListImageUpdated.self) { [weak self] event in
            DispatchQueue.main.async {
                self?.setNeedsUpdateState()
            }
        }
    }
    
    /// Determine if the state needs updating
    var needsUpdateState: Bool = false
    
    /// Tell the state to update
    func setNeedsUpdateState() {
        guard !needsUpdateState else { print("State already set to update"); return }
        needsUpdateState = true
        print("Setting state to update")
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            print("Updating state")
            self.updateState()
            self.needsUpdateState = false
        }
    }
    
    /// Updat the current state
    func updateState() {
        viewState.listItems = deals.map { index in
            print("Sending: " + index.title)
            return ListItemViewState(aisle: index.aisle,
                                     description: index.description,
                                     image: index.image,
                                     price: index.price,
                                     salePrice: index.salePrice,
                                     title: index.title,
                                     deal: index)
        }
        print("State Update Sent")
    }
}


