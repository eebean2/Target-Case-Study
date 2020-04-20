//
//  ListEvents.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

struct ListItemPressed: EventType {
    let deal: TDDeal
}
struct ListItemUpdated: EventType {
    let coordinator: TempoCoordinator
}
struct ListImageUpdated: EventType {}
