//
//  MockPlanetViewService.swift
//  iOS ChallengeTests
//
//  Created by Binshad K B on 17/04/23.
//

import Foundation

@testable import iOS_Challenge

class MockPlanetViewService: PlanetViewServiceProtocol {
    
    var result: Result<PlanetModel, APIError>!
    
    func getPlanets(completion: @escaping (Result<PlanetModel, APIError>) -> Void) {
        completion(result)
    }
    
    func planetList() -> PlanetModel? {
        do {
            guard let fileUrl = Bundle(for: Self.self).url(forResource: "PlanetList", withExtension: "json") else {
                return nil
            }
            let data = try Data(contentsOf: fileUrl)
            return try JSONDecoder().decode(PlanetModel.self, from: data)
        }
        catch {
            return nil
        }
    }
}
