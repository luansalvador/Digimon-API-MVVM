//
//  DigimonViewModelDelegateSpy.swift
//  API-DigimonTests
//
//  Created by Luan Henrique Salvador Amorim on 16/01/23.
//

import Foundation
@testable import API_Digimon

final class DigimonViewModelDelegateSpy: DigimonViewModelDelegate {
    
    private(set) var didFetchUpdateViewCalled: Bool = false
    
    func updateView(digimons: [API_Digimon.DigimonModel]) {
        didFetchUpdateViewCalled = true
    }
}
