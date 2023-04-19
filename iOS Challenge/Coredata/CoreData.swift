//
//  CoreData.swift
//  iOS Challenge
//
//  Created by Binshad K B on 18/04/23.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // Shared cordata context
    
    static let shared = CoreDataStack()
    
    private init() {
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iOS_Challenge")
        
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
}
