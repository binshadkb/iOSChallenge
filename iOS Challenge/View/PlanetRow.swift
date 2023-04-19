//
//  PlanetRow.swift
//  iOS Challenge
//
//  Created by Binshad K B on 17/04/23.
//

import SwiftUI

struct PlanetRow: View {
    
    var planet: Planet
    var body: some View {
        ZStack {
            VStack {
                Text(planet.name)
                                .font(.headline)
                                .foregroundColor(.green)
                                .padding()
                Text("Rotation period:  \(planet.rotationPeriod)")
                    .font(.body)
                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity)
                Text("Orbital period:  \(planet.orbitalPeriod)")
                    .font(.body)
                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity)
                Text("Diameter:  \(planet.diameter)")
                    .font(.body)
                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity)
                Text("Climate:  \(planet.climate)")
                    .font(.body)
                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity)
                Text("Gravity:  \(planet.gravity)")
                    .font(.body)
                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity)
                Text("Terrain:  \(planet.terrain)")
                    .font(.body)
                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity)
                Text("Surface water:  \(planet.surfaceWater)")
                    .font(.body)
                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity)
                Text("Population:  \(planet.population)")
                    .font(.body)
                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity)
            }
            .padding()
        }
    }
}

struct PlanetRow_Previews: PreviewProvider {
    static var previews: some View {
        PlanetRow(planet: Planet(name: "Tatooine", rotationPeriod: "23", orbitalPeriod: "304", diameter: "10465", climate: "arid", gravity: "1 standard", terrain: "desert", surfaceWater: "1", population: "200000", residents: [], films: [], created: "2014-12-09T13:50:49.641000Z", edited: "2014-12-20T20:58:18.411000Z", url: "https://swapi.dev/api/planets/1/"))
    }
}
