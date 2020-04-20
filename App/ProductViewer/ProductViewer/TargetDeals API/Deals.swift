//
//  Deals.swift
//  ProductViewer
//
//  Created by Erik Bean on 4/16/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Foundation
import Tempo

/// List of current deals at Target
public var deals: [TDDeal] { return TDAPI.shared.deals }

/// Update the current list of deals at Target
public func updateDeals(disbatcher: Dispatcher, completion: (() -> Void)? = nil) { TDAPI.shared.update(disbatcher: disbatcher, completion: completion)}

/// API for interacting with the Target Deals API
public final class TDAPI {
    /// Tap into the shared TDAPI instance and access the current deals, or update the list!
    static let shared = TDAPI()
    private init() {}
    
    /// Current list of deals at Target
    public var deals: [TDDeal] = []
    /// The full data wrapped in a TDDataWrapper for easy reading
    /// - Warning: This may be nil, if nil, `deals` will almost always be empty as well
    public var data: TDDataWrapper?
    private var isUpdating: Bool = false
    
    /// Update the current list of deals at Target
    ///
    /// - Note: Calling update will create a new `data` object as well as update the `deals` list if any new deals exist
    public func update(disbatcher: Dispatcher, completion: (() -> Void)? = nil) {
        guard let url = URL(string: "https://target-deals.herokuapp.com/api/deals") else { return }
        print(isUpdating)
        guard !isUpdating else { return }
        self.isUpdating = true
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard error == nil else { self.isUpdating = false; return }
            guard response != nil else { self.isUpdating = false; return }
            guard let data = data else { self.isUpdating = false; return }
            self.data = try! JSONDecoder().decode(TDDataWrapper.self, from: data)
            self.deals = self.data!.data
            self.isUpdating = false
            for i in self.deals {
                CacheManager.shared.cache(url: i.image, for: i.id, options: [.download, .forceOverwrite]) { image in
                    print("Triggering update")
                    disbatcher.triggerEvent(ListImageUpdated())
                }
            }
            completion?()
        }.resume()
    }
}

/// A wrapper to decode the Target Deals high level objects
public struct TDDataWrapper: Codable {
    public let id: UUID = UUID()
    public let _id: String
    public let data: [TDDeal]
    public let type: String
}

/// A wrapper to decode individual deals within the Target Deals API
public struct TDDeal: Codable {
    public let id: UUID = UUID()
    public let _id: String
    public let aisle: String
    public let description: String
    public let guid: String
    public let image: URL
    public let index: Int
    public let price: String
    public let salePrice: String?
    public let title: String
}

extension TDDataWrapper: Equatable {
    public static func == (lhs: TDDataWrapper, rhs: TDDataWrapper) -> Bool { return lhs.id == rhs.id }
}

extension TDDeal: Equatable {
    public static func == (lhs: TDDeal, rhs: TDDeal) -> Bool { return lhs.id == rhs.id }
}
