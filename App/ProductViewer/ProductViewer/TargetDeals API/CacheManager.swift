//
//  CacheManager.swift
//  ProductViewer
//
//  Created by Erik Bean on 4/17/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit

/// Public manager for all cached objects wthin the Target Deals app
public final class CacheManager {
    private init() {}
    public static let shared = CacheManager()
    
    /// Shared cache strictly for images
    public let imageCache = NSCache<NSString, UIImage>()
    
    public func cache(image: UIImage, for key: UUID, options: Options) {
        if !options.contains(.forceOverwrite) && contains(key: key) { return }
        imageCache.setObject(image, forKey: NSString(string: key.uuidString))
    }
    
    /// Update the cache and call completion if there is an image to update
    ///
    /// - Note: This will ONLY call the completion when an image is ready to update. If no image
    ///     has been downloaded, an error occured, or there was invalid options, no error will
    ///     be thrown, and no image will be returned. Only errors from here are during download.
    public func cache(url: URL, for key: UUID, options: Options, completion: ((UIImage) -> Void)? = nil) {
        let isInCache = contains(key: key)
        let override = options.contains(.forceOverwrite)
        let download = options.contains(.download)
        if !override && isInCache {
            if let image = imageCache.object(forKey: NSString(string: key.uuidString)) {
                completion?(image)
            }
            return
        }
        if !isInCache && !download { return }
        if isInCache && download { remove(for: key)}
        Downloader().downloadImage(url: url, for: key.uuidString) { image in
            guard let image = image else { return }
            self.imageCache.setObject(image, forKey: NSString(string: key.uuidString))
            completion?(image)
        }
    }
    
    /// Fetch an image from cache
    public func fetch(for key: UUID) -> UIImage? {
        return imageCache.object(forKey: NSString(string: key.uuidString))
    }

    /// Check if the cache contains an image
    public func contains(key: UUID) -> Bool {
        return imageCache.object(forKey: NSString(string: key.uuidString)) != nil
    }
    
    /// Remove an image from the cahce
    public func remove(for key: UUID) {
        imageCache.removeObject(forKey: NSString(string: key.uuidString))
    }
}

public extension CacheManager {
    struct Options: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }
        
        /// Overrite current image in cache
        static let forceOverwrite   = Options(rawValue: 1 << 0)
        /// Download a new image to store in the cache
        static let download         = Options(rawValue: 1 << 1)
    }
}
