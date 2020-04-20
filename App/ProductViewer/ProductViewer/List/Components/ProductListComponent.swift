//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

struct ProductListComponent: Component {
    var dispatcher: Dispatcher?

    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Setup the view
        view.productImage.layer.cornerRadius = view.productImage.frame.width / 4
        view.productImage.layer.masksToBounds = true
        view.titleLabel.textColor = .targetJetBlackColor
        view.saleLabel.textColor = .targetBullseyeRedColor
        view.priceLabel.textColor = .targetNeutralGrayColor
        view.aisleLabel.textColor = .targetNeutralGrayColor
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        // Configure the view
        let manager = CacheManager.shared
        let deal = item.deal
        if manager.contains(key: deal.id) {
            view.productImage.image = manager.fetch(for: deal.id)
        }
        view.titleLabel.text = deal.title
        view.aisleLabel.text = "Aisle \(deal.aisle.capitalized)"
        if let price = deal.salePrice {
            view.saleLabel.text = price
            view.priceLabel.text = deal.price
        } else {
            view.saleLabel.text = deal.price
            view.priceLabel.text = "Great Deal!"
        }
    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        dispatcher?.triggerEvent(ListItemPressed(deal: item.deal))
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 100.0
    }
}
