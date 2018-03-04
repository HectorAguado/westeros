//
//  Episode.swift
//  westeros
//
//  Created by Hector Aguado on 24/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import Foundation

// MARK: - Episode
final class Episode {
    let title: String
    let releaseDate: Date
    weak var season: Season?  // weak porque es una referencia cruzada. Siempre var y opcional
    let synopsis: String
    
    init(title: String, releaseDate: Date, season: Season, synopsis: String) {
        self.title = title
        self.releaseDate = releaseDate
        self.season = season
        self.synopsis = synopsis
    }
}

// MARK: - Proxies
extension Episode {
    var proxyForEquality: String {
        return "\(title) \(releaseDate) \(season!.name)"
    }
}

// MARK: - CustomStringConvertible
extension Episode: CustomStringConvertible{
    var description: String {
        return "Episodio: \"\(title)\" - Fecha de estreno \(releaseDate.stringfy)"
    }
}
// MARK: - Hashable
extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}
// MARK: - Equatable
extension Episode: Equatable{
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}
// MARK: - Comparable
extension Episode: Comparable{
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.releaseDate < rhs.releaseDate
    }
}
