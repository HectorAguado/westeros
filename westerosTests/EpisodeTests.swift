//
//  EpisodeTests.swift
//  westerosTests
//
//  Created by Hector Aguado on 24/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import XCTest
@testable import westeros

class EpisodeTests: XCTestCase {

    var episodeDate1: Date!
    var episodeDate2: Date!
    var episodeDate3: Date!
    var episode01S01: Episode!
    var episode02S01: Episode!
    var episode01S02: Episode!
    var season1: Season!
    var season2: Season!
    
    override func setUp() {
        super.setUp()
        // Seasons
        let seasonDate1 = Date(dateString: "17-04-2011")
        let seasonDate2 = Date(dateString: "01-04-2012")
        season1 = Season(name: .first, episodes: [], releaseDate: seasonDate1, image: #imageLiteral(resourceName: "season1.jpg"))
        season2 = Season(name: .second, episodes: [], releaseDate: seasonDate2, image: #imageLiteral(resourceName: "season2.jpg"))
        // Episodes
        episodeDate1 = Date(dateString: "17-04-2011")
        episodeDate2 = Date(dateString: "24-04-2011")
        episodeDate3 = Date(dateString: "01-04-2012")
        episode01S01 = Episode(title: "Se acerca el invierno", releaseDate: episodeDate1, season: season1, synopsis: synopsis01S01)
        episode02S01 = Episode(title: "El camino real", releaseDate: episodeDate2, season: season1, synopsis: synopsis02S01)
        episode01S02 = Episode(title: "El Norte no olvida", releaseDate: episodeDate3, season: season2, synopsis: synopsis01S02)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEpisodeExistence(){
        episodeDate1 = Date(dateString: "17-04-2011")
        let episode1 = Episode(title: "Se acerca el Invierno", releaseDate: episodeDate1, season: season1, synopsis: synopsis01S01 )
        XCTAssertNotNil(episode1)
    }
    
    func testEpisodeEquality(){
        // Identidad
        XCTAssertEqual(episode01S01,episode01S01)
        
        // Igualdad
        let jinxed = Episode(title: "Se acerca el invierno", releaseDate: Date(dateString: "17-04-2011"), season: season1, synopsis: synopsis01S01)
        XCTAssertEqual(episode01S01,jinxed )
        
        // Desigualdad
        XCTAssertNotEqual(episode01S01, episode01S02)
    }
    func testEpisodeCustomStringConvertibleValue(){
        XCTAssertEqual(episode01S01.description, "Episodio: \"Se acerca el invierno\" - Fecha de estreno 17-04-2011")
        //return "Episodio: \"\(title)\" - Fecha de estreno \(releaseDate)"
    }
}
