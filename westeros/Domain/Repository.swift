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
    typealias HouseFilter = (House) -> Bool
    
    var houses: [House] { get }  // solo de lectura
    func house(named: String) -> House?  //por si le pasamos un String que no es una casa de GoT
    func houses(filteredBy: HouseFilter ) -> [House]
}

protocol SeasonFactory {
    typealias SeasonFilter = (Season) -> Bool
    
    var seasons: [Season] { get }  // solo lectura
    func seasons(filteredBy: SeasonFilter) -> [Season]
}

final class LocalFactory: HouseFactory, SeasonFactory {
    
    // Mark: - HouseFactory protocol implementation
    var houses: [House] {
    // Houses creation here   #imageLiteral(resourceName: "targaryen.jpg")
        // SIGILs
        let starkSigil     = Sigil(image: #imageLiteral(resourceName: "stark.jpg"), description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "Leon rampante")
        let targaryenSigil = Sigil(image: #imageLiteral(resourceName: "targaryen.jpg"), description: "Dragón de tres cabezas")
        let arrynSigil     = Sigil(image: #imageLiteral(resourceName: "arryn.jpg"), description: "Un creciente y halcón de plata")
        let baratheonSigil = Sigil(image: #imageLiteral(resourceName: "baratheon.jpg"), description: "venado coronado")
        let greyjoySigil   = Sigil(image: #imageLiteral(resourceName: "greyjoy.jpg"), description: "Kraken")
        let martellSigil   = Sigil(image: #imageLiteral(resourceName: "martell.jpg"), description: "Sol atravesado por lanza de oro")
        let tullySigil     = Sigil(image: #imageLiteral(resourceName: "tully2.jpg"), description: "Trucha saltando")
        let tyrellSigil    = Sigil(image: #imageLiteral(resourceName: "tyrell.jpg"), description: "Rosa de oro")
        
        // HOUSEs
        let starkHouse     = House(name: "Stark",     sigil: starkSigil, words: "Se acerca el invierno",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!) //pongo ! porque si URL no es correcta, peta
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        let arrynHouse     = House(name: "Arryn", sigil: arrynSigil, words: "Tan alto como el honor",
                                   url: URL(string:"https://awoiaf.westeros.org/index.php/House_Arryn")!)
        let baratheonHouse = House(name: "Baratheon", sigil: baratheonSigil, words: "Nuestra es la furia",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Baratheon")!)
        let greyjoyHouse   = House(name: "Greyjoy", sigil: greyjoySigil, words: "Nosotros no sembramos",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Greyjoy")!)
        let martellHouse   = House(name: "Martell", sigil: martellSigil, words: "Nunca doblegado, Nunca roto",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Martell")!)
        let tullyHouse     = House(name: "Tully", sigil: tullySigil, words: "Familia, Deber, Honor",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Tully")!)
        let tyrellHouse    = House(name: "Tyrell", sigil: tyrellSigil, words: "Crecer fuerte",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Tyrell")!)
        // CHARACTERs
        let robb   = Person(name: "Robb", alias: "Joven lobo", photo: #imageLiteral(resourceName: "robb.jpg"), house: starkHouse)
        let arya   = Person(name: "Arya", photo: #imageLiteral(resourceName: "arya.jpg"), house: starkHouse)
        let bran   = Person(name: "Brann", photo: #imageLiteral(resourceName: "bra.png"), house: starkHouse)
        let ned    = Person(name: "Eddard", photo: #imageLiteral(resourceName: "eddard.jpg"), house: starkHouse)
        let rickon = Person(name: "Rickon", photo: #imageLiteral(resourceName: "rickon_stark_season_3.jpg"), house: starkHouse)
        let sansa  = Person(name: "Sansa", photo: #imageLiteral(resourceName: "sansa-stark.jpg"), house: starkHouse)
        
        let tywin  = Person(name: "Tywin", photo: #imageLiteral(resourceName: "tywin0.jpg"), house: lannisterHouse)
        let tyrion = Person(name: "Tyrion", alias: "El gnomo", photo: #imageLiteral(resourceName: "tyrion-lannister-in-game-of-thrones-season-7.png"), house: lannisterHouse)
        let cersei = Person(name: "Cersei", photo: #imageLiteral(resourceName: "cersei-lannister-photos.jpg"), house: lannisterHouse)
        let jaime  = Person(name: "Jaime", alias: "El Matarreyes", photo: #imageLiteral(resourceName: "Jaime4.jpg"), house: lannisterHouse)
        
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", photo: #imageLiteral(resourceName: "dany.jpg"), house: targaryenHouse)
        let viserys = Person(name: "Viserys", photo: #imageLiteral(resourceName: "Viserys_Targaryen.jpg"), house: targaryenHouse)
        
        let aeron = Person(name: "Aeron", alias: "Pelomojado", photo: #imageLiteral(resourceName: "Aeron.jpg"), house: greyjoyHouse)
        let balon = Person(name: "Balon", photo: #imageLiteral(resourceName: "Balon-Greyjoy-played-by-Patrick-Malahide.jpg"), house: greyjoyHouse)
        let euron = Person(name: "Euron", alias: "Ojo de Cuervo", photo: #imageLiteral(resourceName: "euron2.jpg"), house: greyjoyHouse)
        let theon = Person(name: "Theon", alias: "Hediondo", photo: #imageLiteral(resourceName: "Theon-Greyjoy.jpg"), house: greyjoyHouse)
        let yara  = Person(name: "Yara", photo: #imageLiteral(resourceName: "yara-greyjoy.0.0.jpg"), house: greyjoyHouse)
        
        let brynden = Person(name: "Brynden", alias: "El Pez Negro", photo: #imageLiteral(resourceName: "brynden_tully2.jpg"), house: tullyHouse)
        let catelyn = Person(name: "Catelyn", photo: #imageLiteral(resourceName: "catelyn.jpg"), house: tullyHouse)
        let edmure  = Person(name: "Edmure", photo: #imageLiteral(resourceName: "edmure-blackfish-3021.jpg"), house: tullyHouse)
        
        
        let doran  = Person(name: "Doran", photo: #imageLiteral(resourceName: "Doran-Martel.jpg"), house: martellHouse)
        let oberyn = Person(name: "Oberyn", alias: "La Vívora Roja", photo: #imageLiteral(resourceName: "oberyn-martel0.jpg"), house: martellHouse)
        
        let robert   = Person(name: "Robert", photo: #imageLiteral(resourceName: "robert1.jpg"), house: baratheonHouse)
        let stannis  = Person(name: "Stannis", photo: #imageLiteral(resourceName: "stannis2.jpg"), house: baratheonHouse)
        let renly    = Person(name: "Renly", photo: #imageLiteral(resourceName: "renly-baratheon.jpg"), house: baratheonHouse)
        let joffrey  = Person(name: "Joffrey", photo: #imageLiteral(resourceName: "joffery3.jpg"), house: baratheonHouse)
        let tommen   = Person(name: "Tommen", photo: #imageLiteral(resourceName: "Tommen_blood_of_my_blood.jpg"), house: baratheonHouse)
        let myrcella = Person(name: "Myrcella", photo: #imageLiteral(resourceName: "Myrcella.png"), house: baratheonHouse)
        
        let john_arryn   = Person(name: "John", photo: #imageLiteral(resourceName: "john_arryn.jpg"), house: arrynHouse)
        let lysa         = Person(name: "Lysa", photo: #imageLiteral(resourceName: "lisa_arryn01.jpg"), house: arrynHouse)
        let robert_arryn = Person(name: "Robert", alias: "Robalito", photo: #imageLiteral(resourceName: "john_arryn_jr.jpg"), house: arrynHouse)
        let petyr        = Person(name: "Petyr Baelish", alias: "Meñique", photo: #imageLiteral(resourceName: "meñique2.jpg"), house: arrynHouse)
        
        let olena    = Person(name: "Olena", alias: "Reina de las espinas", photo: #imageLiteral(resourceName: "olena-tyrell1.jpg"), house: tyrellHouse)
        let loras    = Person(name: "Loras", alias: "El caballero de las Flores", photo: #imageLiteral(resourceName: "loras-tyrell0.jpg"), house: tyrellHouse)
        let margarey = Person(name: "Margarey", photo: #imageLiteral(resourceName: "margarey-tyrell1.jpg"), house: tyrellHouse)
        
    //Add characters to houses
        //starkHouse.add(person: arya)
        starkHouse.add(persons: ned, robb, sansa, arya, bran, rickon )
        lannisterHouse.add(persons: tywin, jaime, cersei, tyrion)
        targaryenHouse.add(persons: viserys, dani)
        greyjoyHouse.add(persons: balon, aeron, euron, yara, theon)
        tullyHouse.add(persons: edmure, brynden, catelyn)
        martellHouse.add(persons: doran, oberyn)
        baratheonHouse.add(persons: robert, stannis, renly, joffrey, tommen, myrcella)
        arrynHouse.add(persons: john_arryn, lysa, robert_arryn, petyr)
        tyrellHouse.add(persons: olena, loras, margarey)
        
        return [starkHouse, lannisterHouse, targaryenHouse, tyrellHouse, tullyHouse, martellHouse, greyjoyHouse, baratheonHouse, arrynHouse].sorted() //devuelva el array ordenado
    }
    
    func house(named name: String) -> House? {
        //let house = houses.filter{ $0.name.uppercased() == name.uppercased() }.first
        let house = houses.first{ $0.name.uppercased() == name.uppercased() }  //equivale a lo de arriba
        return house
    }
    func house(named name: houseType) -> House? {
        let house = houses.first { $0.name == name.rawValue }
        return house
    }
    
    func houses(filteredBy: HouseFilter) -> [House] {
        //varias opciones. Filtrar mis casas por un filtro que me viene por parámetro
        return houses.filter(filteredBy)
    }
    
    // Mark: - SeasonFactory protocol implementation
    var seasons: [Season] {
        // Seasons
        let season1 = Season(name: .first,   episodes: [], releaseDate: Date(dateString: "17-04-2011"), image: #imageLiteral(resourceName: "season1.jpg"))
        let season2 = Season(name: .second,  episodes: [], releaseDate: Date(dateString: "01-04-2012"), image: #imageLiteral(resourceName: "season2.jpg"))
        let season3 = Season(name: .third,   episodes: [], releaseDate: Date(dateString: "31-03-2013"), image: #imageLiteral(resourceName: "season3.jpg"))
        let season4 = Season(name: .fourth,  episodes: [], releaseDate: Date(dateString: "06-04-2014"), image: #imageLiteral(resourceName: "season04.jpg"))
        let season5 = Season(name: .fifht,   episodes: [], releaseDate: Date(dateString: "12-04-2015"), image: #imageLiteral(resourceName: "season5.jpg"))
        let season6 = Season(name: .sixth,   episodes: [], releaseDate: Date(dateString: "24-04-2016"), image: #imageLiteral(resourceName: "season6.jpeg"))
        let season7 = Season(name: .seventh, episodes: [], releaseDate: Date(dateString: "16-07-2017"), image: #imageLiteral(resourceName: "season7.jpeg"))
        
        // Episodes
        let episode01S01 = Episode(title: "Se acerca el invierno", releaseDate: Date(dateString: "17-04-2011"), season: season1, synopsis: synopsis01S01)
        let episode02S01 = Episode(title: "El camino real", releaseDate: Date(dateString: "24-04-2011"), season: season1, synopsis: synopsis02S01)

        let episode03S01 = Episode(title: "Lord Nieve", releaseDate: Date(dateString: "01-05-2011"), season: season1, synopsis: synopsis03S01)
        let episode04S01 = Episode(title: "Tullidos, bastardos y cosas rotas", releaseDate: Date(dateString: "08-05-2011"), season: season1, synopsis: synopsis04S01)
        let episode05S01 = Episode(title: "El lobo y el león", releaseDate: Date(dateString: "15-05-2011"), season: season1, synopsis: synopsis05S01)
        let episode06S01 = Episode(title: "Una corona de oro", releaseDate: Date(dateString: "22-05-2011"), season: season1, synopsis: synopsis06S01)
        let episode07S01 = Episode(title: "Ganas o mueres", releaseDate: Date(dateString: "29-05-2011"), season: season1, synopsis: synopsis07S01)
        let episode08S01 = Episode(title: "Por el lado de la punta", releaseDate: Date(dateString: "05-06-2011"), season: season1, synopsis: synopsis08S01)
        let episode09S01 = Episode(title: "Baelor", releaseDate: Date(dateString: "12-06-2011"), season: season1, synopsis: synopsis09S01)
        let episode10S01 = Episode(title: "Fuego y sangre", releaseDate: Date(dateString: "19-06-2011"), season: season1, synopsis: synopsis10S01)
        
        let episode01S02 = Episode(title: "El Norte no olvida", releaseDate: Date(dateString: "01-04-2012"), season: season2, synopsis: synopsis01S02)
        let episode02S02 = Episode(title: "Las tierras de la noche", releaseDate: Date(dateString: "08-04-2012"), season: season2, synopsis: synopsis02S02)
        let episode03S02 = Episode(title: "Lo que está muerto no puede morir", releaseDate: Date(dateString: "15-04-2012"), season: season2, synopsis: synopsis03S02)
        let episode04S02 = Episode(title: "Jardín de huesos", releaseDate: Date(dateString: "22-04-2012"), season: season2, synopsis: synopsis04S02)
        let episode05S02 = Episode(title: "El fantasma de Harrenhal", releaseDate: Date(dateString: "29-04-2012"), season: season2, synopsis: synopsis05S02)
        let episode06S02 = Episode(title: "Los dioses antiguos y nuevos", releaseDate: Date(dateString: "06-05-2012"), season: season2, synopsis: synopsis06S02)
        let episode07S02 = Episode(title: "Un hombre sin honor", releaseDate: Date(dateString: "13-05-2012"), season: season2, synopsis: synopsis07S02)
        let episode08S02 = Episode(title: "Un príncipe de Invernalia", releaseDate: Date(dateString: "20-05-2012"), season: season2, synopsis: synopsis08S02)
        let episode09S02 = Episode(title: "Aguasnegras", releaseDate: Date(dateString: "27-05-2012"), season: season2, synopsis: synopsis09S02)
        let episode10S02 = Episode(title: "Valar Morghulis", releaseDate: Date(dateString: "03-06-2012"), season: season2, synopsis: synopsis10S02)
        
        

        let episode01S03 = Episode(title: "Valar Dohaeris", releaseDate: Date(dateString: "31-03-2013"), season: season3, synopsis: synopsis01S03)
        let episode02S03 = Episode(title: "Alas negras, palabras negras", releaseDate: Date(dateString: "07-04-2013"), season: season3, synopsis: synopsis02S03)
        let episode03S03 = Episode(title: "El camino del castigo", releaseDate: Date(dateString: "14-04-2013"), season: season3, synopsis: synopsis03S03)
        let episode04S03 = Episode(title: "Y ahora su guardia ha terminado", releaseDate: Date(dateString: "21-04-2013"), season: season3, synopsis: synopsis04S03)
        let episode05S03 = Episode(title: "Besado por el fuego", releaseDate: Date(dateString: "28-04-2013"), season: season3, synopsis: synopsis05S03)
        let episode06S03 = Episode(title: "El ascenso", releaseDate: Date(dateString: "05-05-2013"), season: season3, synopsis: synopsis06S03)
        let episode07S03 = Episode(title: "El oso y la doncella", releaseDate: Date(dateString: "12-05-2013"), season: season3, synopsis: synopsis07S03)
        let episode08S03 = Episode(title: "Los segundos hijos", releaseDate: Date(dateString: "19-05-2013"), season: season3, synopsis: synopsis08S03)
        let episode09S03 = Episode(title: "Las lluvias de Castamere", releaseDate: Date(dateString: "02-06-2013"), season: season3, synopsis: synopsis09S03)
        let episode10S03 = Episode(title: "Mhysa", releaseDate: Date(dateString: "09-06-2013"), season: season3, synopsis: synopsis10S03)
        
        let episode01S04 = Episode(title: "Dos Espadas", releaseDate: Date(dateString: "06-04-2014"), season: season4, synopsis: synopsis01S04)
        let episode02S04 = Episode(title: "El león y la rosa", releaseDate: Date(dateString: "13-04-2014"), season: season4, synopsis: synopsis02S04)
        let episode03S04 = Episode(title: "Rompedora de cadenas", releaseDate: Date(dateString: "20-04-2014"), season: season4, synopsis: synopsis03S04)
        let episode04S04 = Episode(title: "Guardajuramentos", releaseDate: Date(dateString: "27-04-2014"), season: season4, synopsis: synopsis04S04)
        let episode05S04 = Episode(title: "El primero de sus hombres", releaseDate: Date(dateString: "04-05-2014"), season: season4, synopsis: synopsis05S04)
        let episode06S04 = Episode(title: "Leyes de dioses y hombres", releaseDate: Date(dateString: "11-05-2014"), season: season4, synopsis: synopsis06S04)
        let episode07S04 = Episode(title: "Sinsonte", releaseDate: Date(dateString: "18-05-2014"), season: season4, synopsis: synopsis07S04)
        let episode08S04 = Episode(title: "La Montaña y la Vívora", releaseDate: Date(dateString: "01-06-2014"), season: season4, synopsis: synopsis08S04)
        let episode09S04 = Episode(title: "Los vigilantes del Muro", releaseDate: Date(dateString: "08-06-2014"), season: season4, synopsis: synopsis09S04)
        let episode10S04 = Episode(title: "Los niños", releaseDate: Date(dateString: "15-06-2014"), season: season4, synopsis: synopsis10S04)
        
        let episode01S05 = Episode(title: "Las guerras venideras", releaseDate: Date(dateString: "12-04-2015"), season: season5, synopsis: synopsis01S05)
        let episode02S05 = Episode(title: "La casa de negro y blanco", releaseDate: Date(dateString: "19-04-2015"), season: season5, synopsis: synopsis02S05)
        let episode03S05 = Episode(title: "Gorrión Supremo", releaseDate: Date(dateString: "26-04-2015"), season: season5, synopsis: synopsis03S05)
        let episode04S05 = Episode(title: "Hijos de la arpía", releaseDate: Date(dateString: "03-05-2015"), season: season5, synopsis: synopsis04S05)
        let episode05S05 = Episode(title: "Matad al chico", releaseDate: Date(dateString: "10-05-2015"), season: season5, synopsis: synopsis05S05)
        let episode06S05 = Episode(title: "Nunca doblegado, nunca roto", releaseDate: Date(dateString: "17-05-2015"), season: season5, synopsis: synopsis06S05)
        let episode07S05 = Episode(title: "El regalo", releaseDate: Date(dateString: "24-05-2015"), season: season5, synopsis: synopsis07S05)
        let episode08S05 = Episode(title: "Casa Austera", releaseDate: Date(dateString: "31-05-2015"), season: season5, synopsis: synopsis08S05)
        let episode09S05 = Episode(title: "Danza de dragones", releaseDate: Date(dateString: "07-06-2015"), season: season5, synopsis: synopsis09S05)
        let episode10S05 = Episode(title: "Misericordia", releaseDate: Date(dateString: "14-06-2015"), season: season5, synopsis: synopsis10S05)
        
        let episode01S06 = Episode(title: "La mujer roja", releaseDate: Date(dateString: "24-04-2016"), season: season6, synopsis: synopsis01S06)
        let episode02S06 = Episode(title: "A casa", releaseDate: Date(dateString: "01-05-2016"), season: season6, synopsis: synopsis02S06)
        let episode03S06 = Episode(title: "Perjuro", releaseDate: Date(dateString: "08-05-2016"), season: season6, synopsis: synopsis03S06)
        let episode04S06 = Episode(title: "Libro del desconocido", releaseDate: Date(dateString: "15-05-2016"), season: season6, synopsis: synopsis04S06)
        let episode05S06 = Episode(title: "La Puerta", releaseDate: Date(dateString: "22-05-2016"), season: season6, synopsis: synopsis05S06)
        let episode06S06 = Episode(title: "Sangre de mi sangre", releaseDate: Date(dateString: "29-05-2016"), season: season6, synopsis: synopsis06S06)
        let episode07S06 = Episode(title: "El hombre destrozado", releaseDate: Date(dateString: "05-06-2016"), season: season6, synopsis: synopsis07S06)
        let episode08S06 = Episode(title: "Nadie", releaseDate: Date(dateString: "12-06-2016"), season: season6, synopsis: synopsis08S06)
        let episode09S06 = Episode(title: "La batalla de los bastardos", releaseDate: Date(dateString: "19-06-2016"), season: season6, synopsis: synopsis09S06)
        let episode10S06 = Episode(title: "Vientos de invierno", releaseDate: Date(dateString: "26-06-2016"), season: season6, synopsis: synopsis10S06)
        
        let episode01S07 = Episode(title: "Rocadragón", releaseDate: Date(dateString: "16-07-2017"), season: season7, synopsis: synopsis01S07)
        let episode02S07 = Episode(title: "Nacido de la tormenta", releaseDate: Date(dateString: "23-07-2017"), season: season7, synopsis: synopsis02S07)
        let episode03S07 = Episode(title: "La justicia de la reina", releaseDate: Date(dateString: "30-07-2017"), season: season7, synopsis: synopsis03S07)
        let episode04S07 = Episode(title: "Botines de guerra", releaseDate: Date(dateString: "06-08-2017"), season: season7, synopsis: synopsis04S07)
        let episode05S07 = Episode(title: "Guardaoriente", releaseDate: Date(dateString: "13-08-2017"), season: season7, synopsis: synopsis05S07)
        let episode06S07 = Episode(title: "Más allá del Muro", releaseDate: Date(dateString: "20-08-2017"), season: season7, synopsis: synopsis06S07)
        let episode07S07 = Episode(title: "El dragón y el lobo", releaseDate: Date(dateString: "27-08-2017"), season: season7, synopsis: synopsis07S07)

        
        
        
        
        // Adding episodes to Seasons
        season1.add(episodeList: episode01S01, episode02S01, episode03S01, episode04S01, episode05S01, episode06S01, episode07S01, episode08S01, episode09S01, episode10S01)
        season2.add(episodeList: episode01S02, episode02S02, episode03S02, episode04S02, episode05S02, episode06S02, episode07S02, episode08S02, episode09S02, episode10S02)
        season3.add(episodeList: episode01S03, episode02S03, episode03S03, episode04S03, episode05S03, episode06S03, episode07S03, episode08S03, episode09S03, episode10S03)
        season4.add(episodeList: episode01S04, episode02S04, episode03S04, episode04S04, episode05S04, episode06S04, episode07S04, episode08S04, episode09S04, episode10S04)
        season5.add(episodeList: episode01S05, episode02S05, episode03S05, episode04S05, episode05S05, episode06S05, episode07S05, episode08S05, episode09S05, episode10S05)
        season6.add(episodeList: episode01S06, episode02S06, episode03S06, episode04S06, episode05S06, episode06S06, episode07S06, episode08S06, episode09S06, episode10S06)
        season7.add(episodeList: episode01S07, episode02S07, episode03S07, episode04S07, episode05S07, episode06S07, episode07S07)
        return [season7, season6, season5, season4, season3, season2, season1].sorted()  //devuelva el array ordenado
    }
    func seasons(filteredBy: SeasonFilter) -> [Season] {
        return seasons.filter(filteredBy)
    }
//    func houses(filteredBy: HouseFilter) -> [House] {
//        return houses.filter(filteredBy)
//    }
    
    
}
