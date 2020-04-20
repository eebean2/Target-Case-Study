//
//  ListViewState.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

/// List view state
struct ListViewState: TempoViewState, TempoSectionedViewState {
    var listItems: [TempoViewStateItem]
    
    var sections: [TempoViewStateItem] {
        return listItems
    }
}

/// View state for each list item.
struct ListItemViewState: TempoViewStateItem {
    public let id: UUID = UUID()
    public let aisle: String
    public let description: String
    public let image: URL
    public let price: String
    public let salePrice: String?
    public let title: String
    public let deal: TDDeal
}

extension ListItemViewState: Equatable {
    static func == (lhs: ListItemViewState, rhs: ListItemViewState) -> Bool {
        return lhs.id.uuidString == rhs.id.uuidString
    }
}
