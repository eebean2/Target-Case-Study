//
//  DownloadHelper.swift
//  ProductViewer
//
//  Created by Erik Bean on 4/17/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Foundation
import UIKit.UIImage

extension URL {
    static var imageOverideURL: URL { return URL(string: "https://placebeard.it/400/notag.jpeg")! }
}

class Downloader {
    
    private var downloading: [String] = []
    
    public func downloadImage(url: URL, for key: String, attempt: Int = 0, completion: @escaping (UIImage?) -> Void) {
        let url = URL.imageOverideURL
        guard !downloading.contains(key) else {
            rpt(url: url, for: key, attempt: 5, completion: completion); return }
        downloading.append(key)
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            guard error == nil else {
                self.rpt(url: url, for: key, attempt: attempt, completion: completion); return
            }
            guard let response = response else {
                self.rpt(url: url, for: key, attempt: attempt, completion: completion); return
            }
            guard response.mimeType!.contains("image/") else {
                self.rpt(url: url, for: key, attempt: attempt, completion: completion); return
            }
            guard let data = data else {
                self.rpt(url: url, for: key, attempt: attempt, completion: completion); return
            }
            guard let image = UIImage(data: data) else {
                self.rpt(url: url, for: key, attempt: attempt, completion: completion); return
            }
            completion(image)
        }.resume()
    }
    
    private func cr(_ attempt: Int) -> Bool {
        return attempt >= 4
    }
    
    private func rpt(url: URL, for key: String, attempt: Int, completion: @escaping (UIImage?) -> Void) {
        guard cr(attempt) else { completion(nil); return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.downloadImage(url: url, for: key, attempt: attempt + 1, completion: completion)
        }
    }
}
