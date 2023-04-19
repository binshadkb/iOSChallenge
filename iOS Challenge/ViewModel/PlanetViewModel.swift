//
//  PlanetViewModel.swift
//  iOS Challenge
//
//  Created by Binshad K B on 17/04/23.
//

import Foundation

class PlanetViewModel: ObservableObject {
    
    private let planetViewService: PlanetViewServiceProtocol
    @Published var planetList: PlanetModel?
    
    init(planetViewService: PlanetViewServiceProtocol = PlanetViewDataService()) {
        self.planetViewService = planetViewService
    }
    
    func fetchPlanetList() {
        
        planetViewService.getPlanets() { result in
            switch result {
            case .success(let planetList) :
                self.planetList = planetList
            case .failure(let error) :
                print(error)
            }
        }
    }
    
}
