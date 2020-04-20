//
//  DetailViewState.swift
//  ProductViewer
//
//  Created by Erik Bean on 4/17/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

public struct DetailViewState: TempoViewState, TempoSectionedViewState {
    public var items: [TempoViewStateItem]
    
    public var sections: [TempoViewStateItem] {
        return items
    }
}

public struct DetailItemViewState: TempoViewStateItem, Equatable {
    public let deal: TDDeal
}
