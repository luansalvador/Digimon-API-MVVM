//
//  Networking.swift
//  API-Digimon
//
//  Created by user220212 on 6/6/22.
//

import Foundation

protocol DigimonService {
    func fetchDigimons(completion: @escaping (Result<[DigimonModel], Error>) -> Void)
}

class APIManager: DigimonService {
    
    func fetchDigimons(completion: @escaping (Result<[DigimonModel], Error>) -> Void) {
        
        guard let url = URL(string: "https://digimon-api.vercel.app/api/digimon") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse else { return }
            
            let statusCodeValids = [200, 201]
            let statusCode = response.statusCode
            if statusCodeValids.contains(statusCode) {
                guard let data = data else { return }
                
                if let digimon = try? JSONDecoder().decode([DigimonModel].self, from: data){
                    completion(.success(digimon))
                } else {
                    completion(.failure(NSError()))
                }
            }
        }.resume()
    }
}

