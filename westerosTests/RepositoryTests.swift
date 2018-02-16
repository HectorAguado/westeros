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
    
    override func setUp()  {
        super.setUp()
        localHouses = Repository.local.houses
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
        XCTAssertEqual(localHouses.count, 3)
    }
    
    func testLocalRepositoryreturnsSortedArrayOfHouses(){
        XCTAssertEqual(localHouses, localHouses.sorted()) // si ya es igual al ordenado, es que ya esta ordenado
    }
    
    func testLocalRepositoryReturnsHouseByCaseInsensitively(){
        let stark = Repository.local.house(named: "sTaRK")
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testHouseFiltering() {
        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 } )
        XCTAssertEqual(filtered.count, 1)
        
        let otherFilter = Repository.local.houses(filteredBy: { $0.words.contains("invierno")})  // este filtro es mas amplio que el anterior
        XCTAssertEqual(otherFilter.count, 1)
    }
    
}













