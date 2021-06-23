import Foundation

protocol NetworkManagerProtocol{
    func getCharacter(page: Int, name: String, status: String, gender: String, completion: @escaping (Result<CharactersData?, Error>) -> ())
    func getLocation(page: Int, name: String, completion: @escaping (Result<LocationsData?, Error>) -> ())
    func getEpisode(page: Int, name: String, completion: @escaping (Result<EpisodeData?, Error>) -> ())
}

class NetworkManager:NetworkManagerProtocol {
    func getCharacter(page: Int, name: String, status: String, gender: String, completion: @escaping (Result<CharactersData?, Error>) -> ()) {
        let url = URLRequest(url: Endpoint.getCharacter(page: page, name: name, status: status, gender: gender).url)
        URLCache.shared.removeAllCachedResponses()
        
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
    
    func getLocation(page: Int, name: String, completion: @escaping (Result<LocationsData?, Error>) -> ()) {
        let url = URLRequest(url: Endpoint.getLocation(page: page, name: name).url)
        URLCache.shared.removeAllCachedResponses()
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let data = try JSONDecoder().decode(LocationsData.self, from: data!)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getEpisode(page: Int, name: String, completion: @escaping (Result<EpisodeData?, Error>) -> ()) {
        let url = URLRequest(url: Endpoint.getEpisode(page: page, name: name).url)
        URLCache.shared.removeAllCachedResponses()
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let data = try JSONDecoder().decode(EpisodeData.self, from: data!)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
