//
//  PokemonDetailView.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 3/21/21.
//

import SwiftUI

struct PokemonDetailView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            Text("Hello, world!")
                .padding()
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView()
    }
}
