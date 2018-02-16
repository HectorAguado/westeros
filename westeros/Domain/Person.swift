//
//  Character.swift
//  westeros
//
//  Created by Hector Aguado on 8/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import Foundation

final class Person {
    let name: String
    let house: House
    private let _alias: String?   //propiedades privadas, por convención, comienzan por _
    
    var alias: String {
        if let _alias = _alias {
            //existe y esta en _alias
            return _alias
        }else{
            return ""
        }
        //equivale a return _alias ?? ""    --> Si existe _alias lo devuelve y si no devuelve ""
    }
    
    init(name: String, alias: String? = nil, house: House){
        self.name = name
        _alias = alias
        self.house = house
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
    var proxy: String {
        return "\(name) \(alias) \(house.name)"
    }
}
// MARK: - Hashable
extension Person: Hashable {
    var hashValue: Int {
        return proxy.hashValue
    }
}
// MARK: - Equatable
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxy == rhs.proxy
    }
    
    
}








