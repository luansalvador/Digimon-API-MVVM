//
//  MockDigimonServiceSpy.swift
//  API-DigimonTests
//
//  Created by Luan Henrique Salvador Amorim on 16/01/23.
//

import Foundation
@testable import API_Digimon

final class MockDigimonServiceSpy: DigimonService {
    
    private(set) var fetchDigimonsCalled: Bool = false
    private(set) var fetchDigimonsCount: Int = 0
    var fetchDigimonsMockResultToBeReturned: Result<[API_Digimon.DigimonModel], Error>?
    
    func fetchDigimons(completion: @escaping (Result<[API_Digimon.DigimonModel], Error>) -> Void) {
        fetchDigimonsCalled = true
        fetchDigimonsCount += 1
        completion(fetchDigimonsMockResultToBeReturned ?? .failure(NSError()))
        
    }
}
