//
//  DetailController.swift
//  ProductViewer
//
//  Created by Erik Bean on 4/17/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit
import Tempo

class DetailController: UIViewController {
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> DetailController {
        let vc = DetailController()
        vc.coordinator = coordinator
        return vc
    }
    
    fileprivate var coordinator: TempoCoordinator!
    public var deal: TDDeal!
    // Attempting to override status bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
        
    lazy var collectionView: UICollectionView = {
        let layout = HarmonyLayout()
        layout.collectionViewMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .narrow, left: .none)
        layout.defaultSectionMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .none, left: .none)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .targetStarkWhiteColor
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addAndPinSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        title = deal.title
        let comps: [ComponentType] = [ DetailComponent() ]
        let compProvider = ComponentProvider(components: comps, dispatcher: coordinator.dispatcher)
        let adapter = CollectionViewAdapter(collectionView: collectionView, componentProvider: compProvider)
        coordinator.presenters = [ SectionPresenter(adapter: adapter) ]
    }
}
