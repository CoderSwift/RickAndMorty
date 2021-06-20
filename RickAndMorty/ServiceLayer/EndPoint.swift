//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by coder on 14.06.21.
//

import UIKit


struct Endpoint {
    var path: String
    var queryItems:  [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
            components.scheme = "https"
            components.host = "rickandmortyapi.com"
            components.path = "/" + path
            components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        
        return url
    }
    
    static func getCharacter(page:Int, name: String, status:String?, gender: String?) -> Self {
        Endpoint(path: "api/character/", queryItems: [
            URLQueryItem(name: "page", value: String(describing: page)),
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "status", value: status),
            URLQueryItem(name: "gender", value: gender)
            
        ])
    }
}
