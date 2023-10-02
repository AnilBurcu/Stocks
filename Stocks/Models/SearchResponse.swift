//
//  SearchResponse.swift
//  Stocks
//
//  Created by Anıl Bürcü on 2.10.2023.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
}

// MARK: - Result
struct SearchResult: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}


