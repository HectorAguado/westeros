//
//  Season.swift
//  westeros
//
//  Created by Hector Aguado on 22/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

enum ordinalType: String {
    case first   = "Temporada 01"
    case second  = "Temporada 02"
    case third   = "Temporada 03"
    case fourth  = "Temporada 04"
    case fifht   = "Temporada 05"
    case sixth   = "Temporada 06"
    case seventh = "Temporada 07"
    case eighth  = "Temporada 08"
    case nineth  = "Temporada 09"
}

typealias Episodes = Set<Episode>

// MARK: - Season
final class Season {
    let name: ordinalType
    var episodes: Episodes
    let releaseDate : Date
    let image : UIImage
    
    init(name: ordinalType, episodes: Episodes, releaseDate: Date, image: UIImage){
        self.name = name
        self.episodes = episodes
        self.releaseDate = releaseDate
        self.image = image
    }
}

extension Season {
    var count: Int {
        return episodes.count
    }
    var sortedEpisodes: [Episode] {
        return episodes.sorted()
    }
    func add(episode: Episode){
        guard episode.season == self else {
            return
        }
        episodes.insert(episode)
    }
    func add(episodeList: Episode...){
        episodeList.forEach{ add(episode: $0)}
    }
}

// MARK: - Proxy
extension Season {
    var proxyForEquality: String {
        return "\(name) \(releaseDate) \(episodes.count)"
    }
}

// MARK: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        return "\(name.rawValue) - \(episodes.count) Episodios - Estrenada el \(releaseDate.stringfy)"
    }
}

// MARK: - Equatable
extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return name.hashValue
    }
}
// MARK: - Comparable
extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.releaseDate < rhs.releaseDate
    }
}





