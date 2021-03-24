//
//  ContentView.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 3/21/21.
//

import SwiftUI

struct PokemonGridView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            Text("Hello, world!")
                .padding()
        }
    }
}

struct PokemonGridView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonGridView()
    }
}
