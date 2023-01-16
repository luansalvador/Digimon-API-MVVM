//
//  API_DigimonTests.swift
//  API-DigimonTests
//
//  Created by Luan Henrique Salvador Amorim on 16/01/23.
//

import XCTest
@testable import API_Digimon

final class DigimonViewModelTest: XCTestCase {
    
    private var sut: DigimonViewModel!
    private var digimonServiceSpy: MockDigimonServiceSpy!
    private let delegateSpy = DigimonViewModelDelegateSpy()

    override func setUpWithError() throws {
        digimonServiceSpy = MockDigimonServiceSpy()
        sut = DigimonViewModel(digimonService: digimonServiceSpy)
    }

    override func tearDownWithError() throws {
        sut = nil
        digimonServiceSpy = nil
    }
    
    func test_shouldCallFetchDigimonCalled_inMockDigimonServiceSpy() {
        sut.fetchDigimons()
        
        XCTAssertTrue(digimonServiceSpy.fetchDigimonsCalled)
    }
    
    func test_shouldReturnFetchDigimonsCount_inMockDigimonServiceSpy() {
        sut.fetchDigimons()
        
        XCTAssertEqual(digimonServiceSpy.fetchDigimonsCount, 1)
    }
    
    func test_fetchData_whenDigimonModelIsNill_shouldNotCallDelegate() {
        digimonServiceSpy.fetchDigimonsMockResultToBeReturned = nil
        
        sut.delegate = delegateSpy
        sut.fetchDigimons()
        
        XCTAssertFalse(delegateSpy.didFetchUpdateViewCalled)
    }
    
    func test_fetchData_whenDigimonModelIsNotNill_shouldCallDelegate() {
        digimonServiceSpy.fetchDigimonsMockResultToBeReturned = .success([DigimonModel(name: "", img: "", level: "")])
        
        sut.delegate = delegateSpy
        sut.fetchDigimons()
        
        XCTAssertTrue(delegateSpy.didFetchUpdateViewCalled)        
    }
}
