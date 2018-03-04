//
//  SeasonTests.swift
//  westerosTests
//
//  Created by Hector Aguado on 22/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import XCTest
@testable import westeros

class SeasonTests: XCTestCase {

    var season1: Season!
    var season2: Season!
    
    var episode01S01: Episode!
    var episode02S01: Episode!
    var episode01S02: Episode!
    
    override func setUp() {
        super.setUp()
        let seasonDate1 = Date(dateString: "17-04-2011")
        let seasonDate2 = Date(dateString: "01-04-2012")
        season1 = Season(name: .first, episodes: [], releaseDate: seasonDate1, image: #imageLiteral(resourceName: "season1.jpg"))
        season2 = Season(name: .second, episodes: [], releaseDate: seasonDate2, image: #imageLiteral(resourceName: "season1.jpg"))
        episode01S01 = Episode(title: "Se acerca el invierno", releaseDate: Date(dateString: "17-04-2011"), season: season1, synopsis: synopsis01S01)
        episode02S01 = Episode(title: "El camino real", releaseDate: Date(dateString: "24-04-2011"), season: season1, synopsis: synopsis02S01)
        episode01S02 = Episode(title: "El Norte no olvida", releaseDate: Date(dateString: "01-04-2012"), season: season2, synopsis: synopsis01S02)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSeasonExistence(){
        XCTAssertNotNil(season1)
        XCTAssertNotNil(season2)
    }
    
    func testSeasonsNotEqualName(){
        XCTAssertNotEqual(season1.name, season2.name)
    }
    
    func testSeasonEquality(){
        // Identidad
        XCTAssertEqual(season1, season1)
        // Igualdad
        let jinxed = Season(name: .first, episodes: [], releaseDate: Date(dateString: "17-04-2011"), image: #imageLiteral(resourceName: "season1.jpg"))
        XCTAssertEqual(season1, jinxed)
        // Desigualdad
        XCTAssertNotEqual(season1, season2)
    }
    
    func testHashable(){
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonComparison(){
        XCTAssertLessThan(season1, season2)
    }
    
    func testAddEpisodes(){
        XCTAssertEqual(season1.count, 0)
        
        season1.add(episode: episode01S01)
        XCTAssertEqual(season1.count, 1)
        season1.add(episode: episode01S01)
        XCTAssertEqual(season1.count, 1)
        
        season1.add(episode: episode02S01)
        XCTAssertEqual(season1.count, 2)
        
        season1.add(episode: episode01S02)
        XCTAssertEqual(season1.count, 2)
        
        let episode02S02 = Episode(title: "Las tierras de la noche", releaseDate: Date(dateString: "08-04-2012"), season: season2, synopsis: synopsis02S02)
        season2.add(episodeList: episode01S02, episode02S02)
        XCTAssertEqual(season2.count, 2)
    }
    
    func testEpisodesReturnSortedArryayOfEpisodes(){
        season1.add(episodeList: episode02S01, episode01S01)
        XCTAssertEqual(season1.sortedEpisodes, [episode01S01, episode02S01])
    }
    
    func testSeasonCustomStringConvertibleValue(){
        XCTAssertEqual(season1.description, "Temporada 01 - 0 Episodios - Estrenada el 17-04-2011")
    }
}













