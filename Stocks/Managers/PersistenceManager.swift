//
//  PersistenceManager.swift
//  Stocks
//
//  Created by Anıl Bürcü on 2.10.2023.
//

import Foundation

final class PersistenceManager {
    
    static let shared = PersistenceManager()
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        
    }
    
    private init() {}
    
    //MARK: - Public
    
    public var watchlist: [String]{
        return []
    }
    public func addToWatchList(){
        
    }
    public func removeFromWatchList(){
        
    }
    
    //MARK: - Private
    
    private var hasOnboarded: Bool {
        return false
    }
}
