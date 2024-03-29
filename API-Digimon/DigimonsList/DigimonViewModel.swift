//
//  DigimonViewModel.swift
//  API-Digimon
//
//  Created by user220212 on 6/7/22.
//

protocol DigimonViewModelDelegate: AnyObject {
    func updateView(digimons: [DigimonModel])
}

class DigimonViewModel {
    
    private let digimonService: DigimonService
    weak var delegate: DigimonViewModelDelegate?
    
    init(digimonService: DigimonService) {
        self.digimonService = digimonService
    }
    
    func fetchDigimons() {        
        self.digimonService.fetchDigimons { [weak self] digimonsResponse in
            switch digimonsResponse {
            case .success(let digimons):
                self?.delegate?.updateView(digimons: digimons)
            case .failure:
                print("Failed to fetch digimon")
            }
        }
    }
}
