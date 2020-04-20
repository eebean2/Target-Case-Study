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
        view.productImage.layer.cornerRadius = view.productImage.frame.width / 4
        view.productImage.layer.masksToBounds = true
        view.titleLabel.textColor = .targetJetBlackColor
        view.saleLabel.textColor = .targetBullseyeRedColor
        view.priceLabel.textColor = .targetNeutralGrayColor
        view.aisleLabel.textColor = .targetNeutralGrayColor
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        print("Receiving: " + item.deal.title)
        view.titleLabel.text = item.title
        view.aisleLabel.text = item.aisle
        if let price = item.salePrice {
            view.saleLabel.text = price
            view.priceLabel.text = item.price
        } else {
            view.saleLabel.text = item.price
            view.priceLabel.text = "Great Deal!"
        }
        if CacheManager.shared.contains(key: item.id) {
            view.productImage.image = CacheManager.shared.fetch(for: item.id)
        } else {
            view.productImage.image = UIImage.clearImage
        }
    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        print("Sending: \(item.title)")
        dispatcher?.triggerEvent(ListItemPressed(deal: item.deal))
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 100.0
    }
}
