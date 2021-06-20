//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by coder on 14.06.21.
//

import Foundation

protocol NetworkManagerProtocol{
    func getCharacter(page: Int, name: String, status: String, gender: String, completion: @escaping (Result<CharactersData?, Error>) -> ())
}

class NetworkManager:NetworkManagerProtocol {
    
    func getCharacter(page: Int, name: String, status: String, gender: String, completion: @escaping (Result<CharactersData?, Error>) -> ()) {
        let url = URLRequest(url: Endpoint.getCharacter(page: page, name: name, status: status, gender: gender).url)
        URLCache.shared.removeAllCachedResponses()
        print(url)
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let data = try JSONDecoder().decode(CharactersData.self, from: data!)
                completion(.success(data))
            } catch {
                completion(.failure(error))

            }
            
        }.resume()
        
    }
    
}
