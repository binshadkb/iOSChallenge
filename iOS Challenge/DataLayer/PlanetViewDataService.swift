//
//  PlanetViewDataService.swift
//  iOS Challenge
//
//  Created by Binshad K B on 18/04/23.
//

import Foundation

// Get data from Database if data exists else retrive from Api and save to database

class PlanetViewDataService: PlanetViewServiceProtocol {
    
    let networkService = PlanetViewService()
    
    func getPlanets(completion: @escaping (Result<PlanetModel, APIError>) -> Void) {
        
        let coredataService = PlanetViewCoreDataService(persistentContainer: CoreDataStack.shared.persistentContainer)
        coredataService.getPlanets() { result in
            switch result {
            case .success(let planetList) :
                completion(.success(planetList))
            case .failure(_) :
                self.getPlanetsFromApi(completion: completion)
                break
            }
        }
    }
    
    
    func getPlanetsFromApi(completion: @escaping (Result<PlanetModel, APIError>) -> Void) {
        
        let coredataService = PlanetViewCoreDataService(persistentContainer: CoreDataStack.shared.persistentContainer)
        networkService.getPlanets() { result in
            switch result {
            case .success(let planetList) :
                coredataService.saveToCoreData(dataModel: planetList)
                completion(.success(planetList))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
}
