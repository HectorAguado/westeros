//
//  House test.swift
//  westerosTests
//
//  Created by Hector Aguado on 8/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import XCTest
@testable import westeros

class HouseTests: XCTestCase {
    
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    
    override func setUp() {
        super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "Leon rampante")
        
        starkHouse     = House(name: "Stark",     sigil: starkSigil, words: "Se acerca el invierno",
                                   url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!) //pongo ! porque si URL no es correcta, peta
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido",
                                   url: URL(string: "http://awoiaf.westeros.org/index.php/House_Lannister")!)
        
        robb = Person(name: "Robb", alias: "Joven lobo", photo: #imageLiteral(resourceName: "robb.jpg"), house: starkHouse)
        arya = Person(name: "Arya", photo: #imageLiteral(resourceName: "arya.jpg"), house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El gnomo", photo: #imageLiteral(resourceName: "tyrion-lannister-in-game-of-thrones-season-7.png"), house: lannisterHouse)
    }
    
    override func tearDown() {
        super.tearDown()
    }
   
    func testHouseExistence() {
        //Varias nomenclaturas para nombrar los test, una la de arriba, "NOMBRAR LA FUNCIONALIDAD"
        //otra basada en esto: given // when  // then  --> que sería
        // testHouse_Existance_ShouldReturnIfHouseExist
        
        XCTAssertNotNil(starkHouse)
        XCTAssertNotNil(lannisterHouse)
    }
    
    func testSigilExistence(){
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    func testAddPersons(){
        XCTAssertEqual(starkHouse.count, 0)
        
        starkHouse.add(person: robb)
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: robb)
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
//        starkHouse.add(person: tyrion)
//        XCTAssertEqual(starkHouse.count, 2)
        let cersei = Person(name: "Cersei", photo: #imageLiteral(resourceName: "cersei-lannister-photos.jpg"), house: lannisterHouse)
        let jaime  = Person(name: "Jaime", alias: "El Matarreyes", photo: #imageLiteral(resourceName: "Jaime4.jpg"), house: lannisterHouse)
        lannisterHouse.add(persons: cersei, jaime, jaime, jaime, robb)
        XCTAssertEqual(lannisterHouse.count, 2)
    }
    
    func testHouseEquality(){
        // Identidad
        XCTAssertEqual(starkHouse, starkHouse)

        // Igualdad
        let jinxed = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno",
                           url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        XCTAssertEqual(jinxed, starkHouse)
        
        // Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHashable(){
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseComparison(){
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
    
    func testHouseReturnSortedArryaOfMembers(){
        starkHouse.add(persons: robb, arya)
        XCTAssertEqual(starkHouse.sortedMembers, [arya, robb ])
        
    }
}






