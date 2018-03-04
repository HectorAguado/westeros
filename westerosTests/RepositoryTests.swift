//
//  RepositoryTests.swift
//  westerosTests
//
//  Created by Hector Aguado on 13/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import XCTest
@testable import westeros

class RepositoryTests: XCTestCase {
    
    var localHouses: [House]!
    var localSeasons: [Season]!
    
    override func setUp()  {
        super.setUp()
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLocalRepositoryCreation() {
        let local = Repository.local
        XCTAssertNotNil(local)
    }
    
    func testLocalRepositoryHousesCreation(){
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 9)
    }
    func testLocalRepositorySeasonsCreation(){
        XCTAssertNotNil(localSeasons)
        XCTAssertEqual(localSeasons.count, 7)
    }
    
    func testLocalRepositoryreturnsSortedArrayOfHouses(){
        XCTAssertEqual(localHouses, localHouses.sorted()) // si ya es igual al ordenado, es que ya esta ordenado
    }
    func testLocalRepositoryreturnsSortedArrayOfSeasons(){
        XCTAssertEqual(localSeasons, localSeasons.sorted()) // si ya es igual al ordenado, es que ya esta ordenado
    }
    
    func testLocalRepositoryReturnsHouseByCaseInsensitively(){
        let stark = Repository.local.house(named: "sTaRK")
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
        
        let lannister = Repository.local.house(named: .Lannister)
        XCTAssertEqual(lannister?.name, "Lannister")
    }
    
    func testHouseFiltering() {
        let filtered = Repository.local.houses(filteredBy: { $0.count == 2 } )
        XCTAssertEqual(filtered.count, 2)
        
        let otherFilter = Repository.local.houses(filteredBy: { $0.words.contains("invierno")})  // este filtro es mas amplio que el anterior
        XCTAssertEqual(otherFilter.count, 1)
    }
    
    func testseasonFiltering() {
        let filtered = Repository.local.seasons(filteredBy: { $0.count == 2})
        XCTAssertEqual(filtered.count, 7)
        
        let DateFilter = Date(dateString: "01-01-2012")
        let otherFilter = Repository.local.seasons(filteredBy: { $0.releaseDate < DateFilter})
        XCTAssertEqual(otherFilter.count, 1)
        
    }
    
    
}













