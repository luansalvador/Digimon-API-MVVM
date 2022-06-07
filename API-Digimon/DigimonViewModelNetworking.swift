//
//  Networking.swift
//  API-Digimon
//
//  Created by user220212 on 6/6/22.
//

import Foundation
import UIKit

var digimonsArray: [DigimonModel] = []


class DigimonViewModelNetworking {
    
    class func getDigimon(_ completion: @escaping ([DigimonModel]) -> Void) {
        guard let url = URL(string: "https://digimon-api.vercel.app/api/digimon") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do{
                        let digimons = try JSONDecoder().decode([DigimonModel].self, from: data)
                        for digimon in digimons {
                            print(digimon.img)
                            completion(digimons)
                        }
                            //completion(digimons)
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Status inválido do servidor, Status Code: \(response.statusCode)")
                }
            } else {
                print(error?.localizedDescription)
            }
        }.resume()
    }
    
    func digimonIMG(at indexPath: IndexPath, imageView: UIImageView?) {
        guard let url = URL(string: digimonsArray[indexPath.row].img) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                imageView?.image = image
            }
        }.resume()
    }
}
