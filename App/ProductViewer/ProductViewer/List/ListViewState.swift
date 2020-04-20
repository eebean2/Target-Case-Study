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
    public let deal: TDDeal
}

extension ListItemViewState: Equatable {
    static func == (lhs: ListItemViewState, rhs: ListItemViewState) -> Bool {
        return lhs.deal.id.uuidString == rhs.deal.id.uuidString
    }
}
