//
//  CharactersData.swift
//  RickAndMorty
//
//  Created by coder on 29.05.21.
//

import Foundation

struct CharactersData:Decodable {
    var info: CharactersInfo?
    var result: CharactersResult?
}

struct CharactersInfo:Decodable {
    var page: Int?
}

struct CharactersResult:Decodable {
    var name: String?
    var status: String?
    var species: String?
    var gender: String?
    var location: Location?
    var image: String?
    var episode: [String]?
}

struct Location:Decodable {
    var name: String?
    var url: String?
}


