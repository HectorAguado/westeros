//
//  Repository.swift
//  westeros
//
//  Created by Hector Aguado on 13/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import Foundation

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias Filter = (House) -> Bool
    
    var houses: [House] { get }  // solo de lectura
    func house(named: String) -> House?  //por si le pasamos un String que no es una casa de GoT
    func houses(filteredBy: Filter ) -> [House]
}


final class LocalFactory: HouseFactory {
   
    var houses: [House] {
        // Houses creation here   #imageLiteral(resourceName: "codeiscomming.png")
        let starkSigil     = Sigil(image: #imageLiteral(resourceName: "codeIsComing.png"), description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "Leon rampante")
        let targaryenSigil = Sigil(image: #imageLiteral(resourceName: "targaryenSmall.jpg"), description: "Dragón de tres cabezas")
        
        let starkHouse     = House(name: "Stark",     sigil: starkSigil, words: "Se acerca el invierno",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!) //pongo ! porque si URL no es correcta, peta
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        let robb = Person(name: "Robb", alias: "Joven lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        
        let tyrion = Person(name: "Tyrion", alias: "El gnomo", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime  = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
        // Add characters to houses
        starkHouse.add(person: arya)
        starkHouse.add(person: robb)
        lannisterHouse.add(person: tyrion)
        lannisterHouse.add(person: cersei)
        lannisterHouse.add(person: jaime)
        targaryenHouse.add(person: dani)
        return [starkHouse, lannisterHouse, targaryenHouse].sorted() //devuelva el array ordenado
    }
    
    func house(named name: String) -> House? {
        //let house = houses.filter{ $0.name.uppercased() == name.uppercased() }.first
        let house = houses.first{ $0.name.uppercased() == name.uppercased() }  //equivale a lo de arriba
        return house
    }
    
    func houses(filteredBy: Filter) -> [House] {
        //varias opciones. Filtrar mis casas por un filtro que me viene por parámetro
        return houses.filter(filteredBy)
    }
}
