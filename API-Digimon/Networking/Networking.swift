//
//  Networking.swift
//  API-Digimon
//
//  Created by user220212 on 6/6/22.
//

import Foundation
import UIKit

struct Networking {
    
    //static var digimonsArray: [DigimonModel] = []
    
    static func getDigimons(_ completion: @escaping ([DigimonModel]) -> Void) {
        guard let url = URL(string: "https://digimon-api.vercel.app/api/digimon") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse else { return }
            
            let statusCodeValids = [200, 201]
                        let statusCode = response.statusCode ?? 0
                        if statusCodeValids.contains(statusCode) {
                    guard let data = data else { return }
                    do {
                        let digimons = try JSONDecoder().decode([DigimonModel].self, from: data)
                        for digimon in digimons {
                            print(digimon.img)
                        }
                        completion(digimons)
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Status inválido do servidor, Status Code: \(response.statusCode)")
                }
            
        }.resume()
    }
    
    func digimonIMG(stringToURL: String, imageView: UIImageView?) {
        guard let url = URL(string: stringToURL) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { print("caiu aqui") ;return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                imageView?.image = image
            }
        }.resume()
    }
}
//KINGFISHER
