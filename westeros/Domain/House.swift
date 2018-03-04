//
//  House.swift
//  westeros
//
//  Created by Hector Aguado on 8/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//
import UIKit

typealias Words = String
typealias Members = Set<Person>   // no permite elementos duplicados, por eso nos obliga a implementar Equatable

enum houseType: String {
    case Arryn      = "Arryn"
    case Baratheron = "Baratheon"
    case Greyjoy    = "Greyjoy"
    case Lannister  = "Lannister"
    case Martell    = "Martell"
    case Stark      = "Stark"
    case Targaryen  = "Targaryen"
    case Tully      = "Tully"
    case Tyrell     = "Tyrell"
}

// MARK: - House
final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members

    init(name: String, sigil: Sigil, words: Words, url: URL){
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = url
        _members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    var sortedMembers:[Person]{
        return _members.sorted()
    }
    func add(person: Person){
        guard person.house == self else {
            return
        }
        _members.insert(person)
    }
    
    func add(persons: Person...) {  // ... significa que puede recibir uno o más elementos, separados por comas
        //Aqui, persons es de tipo [Person]
//        for person in persons{
//            add(person: person)
//        }
        // o mejor
        persons.forEach{ add(person: $0)}
    }
}
// MARK: - Proxy
extension House {
    var proxyForEquality: String {
        return "\(name) \(words) \(count)"
    }
    var proxyForComparison: String {
        return name.uppercased()
    }
}

// MARK: - Equatable
extension House: Equatable{
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension House: Hashable{
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension House: Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
// Como ya tenemos Equatable, con saber cual es menor, tambien sabemos lo contrario, es decir, todas las posibilidades de comparacion e igualdad
    
}

// MARK: - Sigil
final class Sigil {
    let description: String
    let image: UIImage
    
    init(image: UIImage, description: String){
        self.image = image
        self.description = description
    }
}








