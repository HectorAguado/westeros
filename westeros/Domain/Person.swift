//
//  Character.swift
//  westeros
//
//  Created by Hector Aguado on 8/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

final class Person {
    let name: String
    let house: House
    private let _alias: String?   //propiedades privadas, por convención, comienzan por _
    let photo: UIImage
    var alias: String {
        if let _alias = _alias {
            //existe y esta en _alias
            return _alias
        }else{
            return ""
        }
        //equivale a return _alias ?? ""    --> Si existe _alias lo devuelve y si no devuelve ""
    }
    
    init(name: String, alias: String? = nil, photo: UIImage, house: House){
        self.name = name
        _alias = alias
        self.house = house
        self.photo = photo
    }
//    init(name: String, house: House) {
//        self.name = name
//        self.house = house
//        _alias = nil
//    }

}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

// MARK: - Proxies
extension Person {
    var proxyForEquality: String {
        return "\(name) \(alias) \(house.name)"
    }
    var proxyforComparison: String {
        return fullName
    }
}
// MARK: - Hashable
extension Person: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}
// MARK: - Equatable
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}
// MARK: - Comparable
extension Person: Comparable {
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyforComparison < rhs.proxyforComparison
    }
    
        
}









