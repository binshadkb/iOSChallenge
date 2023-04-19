//
//  ContentView.swift
//  iOS Challenge
//
//  Created by Binshad K B on 17/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel = PlanetViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    let planets = viewModel.planetList?.planets ?? []
                    
                    ForEach(planets) { planet in
                        PlanetRow(planet: planet)
                            .listRowSeparator(.hidden)
                            .background(Image(uiImage: UIImage(named: "Space")!))
                            .cornerRadius(10)
                    }
                }
            }
            .onAppear {
                viewModel.fetchPlanetList()
            }
            .navigationTitle("Planet List")
            .background(Color.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
