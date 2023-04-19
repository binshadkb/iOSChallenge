//
//  PlanetModel.swift
//  iOS Challenge
//
//  Created by Binshad K B on 17/04/23.
//

import Foundation


// MARK: - PlanetList
struct PlanetModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let planets: [Planet]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next, previous
        case planets = "results"
    }
}

//MARK: - PlanetModel
public class Planet: Codable, Identifiable {
    
    public let id = UUID()
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
    
    init(name: String, rotationPeriod: String, orbitalPeriod: String, diameter: String, climate: String, gravity: String, terrain: String, surfaceWater: String, population: String, residents: [String], films: [String], created: String, edited: String, url: String) {
        
        self.name = name
        self.rotationPeriod = rotationPeriod
        self.orbitalPeriod = orbitalPeriod
        self.diameter = diameter
        self.climate = climate
        self.gravity = gravity
        self.terrain = terrain
        self.surfaceWater = surfaceWater
        self.population = population
        self.created = created
        self.edited = edited
        self.url = url
        self.residents = residents
        self.films = films
    }
}
