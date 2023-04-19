//
//  PlanetViewService.swift
//  iOS Challenge
//
//  Created by Binshad K B on 17/04/23.
//

import Foundation


// Get data from Api

protocol PlanetViewServiceProtocol {
    func getPlanets(completion: @escaping(Result<PlanetModel, APIError>) -> Void)
}


class PlanetViewService: PlanetViewServiceProtocol {
    
    func getPlanets(completion: @escaping(Result<PlanetModel, APIError>) -> Void) {
        
        APIClient().get(with: "planets", params: nil, completion: completion)
    }
}
