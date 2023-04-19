//
//  PlanetViewModelTests.swift
//  iOS ChallengeTests
//
//  Created by Binshad K B on 17/04/23.
//

import XCTest
@testable import iOS_Challenge

class PlanetViewModelTests: XCTestCase {

    func testPlanetListSuccess() throws {
        let mockService = MockPlanetViewService()
        guard let planetModel = mockService.planetList() else { return }
        mockService.result = .success(planetModel)
        let viewModel = PlanetViewModel(planetViewService: mockService)
        viewModel.fetchPlanetList()
        XCTAssert(viewModel.planetList != nil)
    }
    
    func testPlanetListFailure() throws {
        let mockService = MockPlanetViewService()
        mockService.result = .failure(.invalidData)
        let viewModel = PlanetViewModel(planetViewService: mockService)
        viewModel.fetchPlanetList()
        XCTAssert(viewModel.planetList == nil)
    }
}
