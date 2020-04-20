//
//  DetailView.swift
//  ProductViewer
//
//  Created by Erik Bean on 4/17/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit
import Tempo

class DetailView: UIView {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var salesPrice: UILabel!
    @IBOutlet weak var aisle: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var title: UILabel!
}

extension DetailView: ReusableNib {
    @nonobjc static let nibName = "DetailView"
    @nonobjc static let reuseID = "DetailViewIdentifier"
}
