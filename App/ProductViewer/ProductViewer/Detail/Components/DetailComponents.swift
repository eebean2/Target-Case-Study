//
//  DetailComponents.swift
//  ProductViewer
//
//  Created by Erik Bean on 4/17/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

struct DetailComponent: Component {
    
    var dispatcher: Dispatcher?
    
    func prepareView(_ view: DetailView, item: DetailItemViewState) {
        // Runs only when the view first launches
        view.image.layer.cornerRadius = view.image.frame.height / 4
        view.image.layer.masksToBounds = true
        view.image.image = UIImage.clearImage
        view.backgroundColor = .clear
        view.price.textColor = .targetBullseyeRedColor
        view.cartButton.backgroundColor = .targetBullseyeRedColor
        view.cartButton.setTitleColor(.targetStarkWhiteColor, for: .normal)
        view.cartButton.layer.cornerRadius = view.cartButton.frame.height / 3
        view.listButton.backgroundColor = .targetStrokeGrayColor
        view.listButton.setTitleColor(.targetNeutralGrayColor, for: .normal)
        view.listButton.layer.cornerRadius = view.listButton.frame.height / 3
        view.salesPrice.textColor = .targetBullseyeRedColor
        view.price.textColor = .targetNeutralGrayColor
        view.title.textColor = .targetJetBlackColor
        view.descriptionLabel.textColor = .targetJetBlackColor
        view.descriptionLabel.backgroundColor = .clear
    }
    
    func configureView(_ view: DetailView, item: DetailItemViewState) {
        // Configure the view here
        let manager = CacheManager.shared
        let deal = item.deal
        if manager.contains(key: deal.id) {
            view.image.image = manager.fetch(for: deal.id)
        }
        view.aisle.text = "Aisle \(deal.aisle.capitalized(with: Locale.current))"
        if let price = deal.salePrice {
            view.salesPrice.text = price
            view.price.text = deal.price
        } else {
            view.salesPrice.text = deal.price
            view.price.text = "Great Deal!"
        }
        view.title.text = deal.title
        view.descriptionLabel.text = deal.description
    }
}

extension DetailComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 672.0
    }
}
