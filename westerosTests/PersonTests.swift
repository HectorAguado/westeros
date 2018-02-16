//
//  CharacterTests.swift
//  westerosTests
//
//  Created by Hector Aguado on 8/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import XCTest
@testable import westeros

class PersonTests: XCTestCase {
    //nunca vamos a inicializar los test. Asi, si no doy valor a la variable en algun momento, petará, que es lo que busco,
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    // swift, que odia a nil, nos obliga a inicializar las variables o a declararlas opcionales ?
    // Como en los test no vamos a inicializar, deberíamos usar siempree ? y desempaquetar siempre que las vayamos a usar
    // Para no tener que desempaquetar siempre ( en el setup, sigil debe ser de tipo Sigil, no de tipo Sigil?, por lo que me obliga a desempaquetar. Y así puede ocurrirnos varias veces
    // por eso vamos a forzar de forma explicita !, para que swift nos permita declarar variables sin darle valor al declararlas, y en caso de que se intente acceder a ella, y sea nil, petará.
    
    override func setUp() {
        super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "Leon rampante")
        
        starkHouse     = House(name: "Stark",     sigil: starkSigil, words: "Se acerca el invierno",
                                   url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!) //pongo ! porque si URL no es correcta, peta
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido",
                                   url: URL(string: "http://awoiaf.westeros.org/index.php/House_Lannister")!)
        
        robb = Person(name: "Robb", alias: "Joven lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El gnomo", house: lannisterHouse)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCharacterExistance (){
        XCTAssertNotNil(robb)
        XCTAssertNotNil(arya)
    }
    
    func testFullName() {
        XCTAssertEqual(robb.fullName, "Robb Stark")
    }

    func testPersonEquality() {
        // Identidad
        XCTAssertEqual(tyrion, tyrion)
        
        // Igualdad
        let enano = Person(name: "Tyrion", alias: "El gnomo", house: lannisterHouse)
        XCTAssertEqual(enano, tyrion)
        
        // Desigualdad
        XCTAssertNotEqual(tyrion, arya)
    }
    
}












