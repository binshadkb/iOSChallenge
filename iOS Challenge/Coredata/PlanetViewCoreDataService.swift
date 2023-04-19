//
//  PlanetViewDataService.swift
//  iOS Challenge
//
//  Created by Binshad K B on 18/04/23.
//

import Foundation
import CoreData

// Save and retrive data from database

class PlanetViewCoreDataService: PlanetViewServiceProtocol {
    
    private let persistentContainer: NSPersistentContainer
        
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getPlanets(completion: @escaping(Result<PlanetModel, APIError>) -> Void) {
        
        let fetchRequest: NSFetchRequest<PlanetModelEnitity> = PlanetModelEnitity.fetchRequest()
    
        let context = persistentContainer.viewContext

        do {
            // Peform Fetch Request
            let planetModel = try context.fetch(fetchRequest)
            if let model = planetModel.first {
                
                
                guard let data = model.planets as? Data  else {
                    completion(.failure(.invalidData))
                    return
                }
                
                let planets = try JSONDecoder().decode([Planet].self, from: data)
                
                let planetModel = PlanetModel(count: Int(model.count), next: model.next, previous: model.previous, planets: planets)
                completion(.success(planetModel))

            }
            else {
                completion(.failure(.noData))
            }
        } catch let error {
            print(error)
            completion(.failure(.runtimeError(error.localizedDescription)))
        }
    }
    
    func saveToCoreData(dataModel: PlanetModel) {
        let context = persistentContainer.viewContext
        
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlanetModelEnitity")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try context.execute(deleteRequest)
            
            guard let entity = NSEntityDescription.entity(forEntityName: "PlanetModelEnitity", in: context) else {
                return
            }
            
            guard let planetModelEnitity = NSManagedObject(entity: entity, insertInto: context) as? PlanetModelEnitity else {
                return
            }
            
            planetModelEnitity.count = Int64(dataModel.count)
            planetModelEnitity.next = dataModel.next
            planetModelEnitity.previous = dataModel.previous
            
            let planetData = try JSONEncoder().encode(dataModel.planets)
            
            planetModelEnitity.planets = planetData as NSObject
            
            try context.save()
            
        } catch {
            print("Error saving to Core Data: \(error)")
        }
    }
}
