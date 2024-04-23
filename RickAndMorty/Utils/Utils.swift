//
//  Utils.swift
//  RickAndMorty
//
//  Created by Francisco Lucena on 23/4/24.
//

import Foundation

func loadJson<T: Decodable>(filename fileName: String, with type: T.Type) -> T? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            return try data.decodedResponse(type.self)
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
