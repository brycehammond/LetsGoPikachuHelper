//
//  PokemonBattleAdvisor.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 2/12/21.
//

import Foundation

class PokemonBattleAdvisor {

    static let shared = PokemonBattleAdvisor()

    private lazy var attackGrid: [PokemonType: [PokemonType: Float]] = {
        return buildAttackTable()
    }()

    private static let types: [PokemonType] = [.normal, .fighting, .flying, .poison,
                                       .ground, .rock, .bug, .ghost, .steel,
                                       .fire, .water, .grass, .electric, .psychic,
                                       .ice, .dragon, .dark, .fairy]

    private struct TypeEffectiveness {
        let type: PokemonType
        let value: Float

        init(type: PokemonType, value: Float) {
            self.type = type
            self.value = value
        }
    }

    func getBattleAdviceFor(opponent: Pokemon) -> BattleAdvice {

        var goodChoices = [TypeEffectiveness]()
        var badChoices = [TypeEffectiveness]()

        for type in Self.types {
            if opponent.types.contains(type) {
                //see what NOT to play that this type is effective against
                
            }

            if let attackEffectiveness = attackGrid[type] {
                for (defenseType, effectiveness) in attackEffectiveness {
                    if opponent.types.contains(defenseType) {
                        //Take which attacks types are effective against this type

                    }
                }
            }
        }

        return BattleAdvice(goodTypes: [], badTypes: [])
    }
}

private extension PokemonBattleAdvisor {

    func buildAttackTable() -> [PokemonType: [PokemonType: Float]] {

        var battleGrid = [PokemonType: [PokemonType: Float]]()

        battleGrid[.normal] = createRow(values: [1, 1, 1, 1, 1, 0.5, 1, 0, 0.5, 1, 1, 1, 1, 1, 1, 1, 1, 1])
        battleGrid[.fighting] = createRow(values: [2, 1, 0.5, 0.5, 1, 2, 0.5, 0, 2, 1, 1, 1, 1, 0.5, 2, 1, 2, 0.5])
        battleGrid[.flying] = createRow(values: [1, 2, 1, 1, 1, 0.5, 2, 1, 0.5, 1, 1, 2, 0.5, 1, 1, 1, 1, 1])
        battleGrid[.poison] = createRow(values: [1, 1, 1, 0.5, 0.5, 0.5, 1, 0.5, 0, 1, 1, 2, 1, 1, 1, 1, 1, 2])
        battleGrid[.ground] = createRow(values: [1, 1, 0, 2, 1, 2, 0.5, 1, 2, 2, 1, 0.5, 2, 1, 1, 1, 1, 1])
        battleGrid[.rock] = createRow(values: [1, 0.5, 2, 1, 0.5, 1, 2, 1, 0.5, 2, 1, 1, 1, 1, 2, 1, 1, 1])
        battleGrid[.bug] = createRow(values: [1, 0.5, 0.5, 0.5, 1, 1, 1, 0.5, 0.5, 0.5, 1, 2, 1, 2, 1, 1, 2, 0.5])
        battleGrid[.ghost] = createRow(values: [0, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 0.5, 1])
        battleGrid[.steel] = createRow(values: [1, 1, 1, 1, 1, 2, 1, 1, 0.5, 0.5, 0.5, 1, 0.5, 1, 2, 1, 1, 2])
        battleGrid[.fire] = createRow(values: [1, 1, 1, 1, 1, 0.5, 2, 1, 2, 0.5, 0.5, 2, 1, 1, 2, 0.5, 1, 1])
        battleGrid[.water] = createRow(values: [1, 1, 1, 1, 2, 2, 1, 1, 1, 2, 0.5, 0.5, 1, 1, 1, 0.5, 1, 1])
        battleGrid[.grass] = createRow(values: [1, 1, 0.5, 0.5, 2, 2, 0.5, 1, 0.5, 0.5, 1, 0.5, 1, 1, 1, 0.5, 1, 1])
        battleGrid[.electric] = createRow(values: [1, 1, 2, 1, 0, 1, 1, 1, 1, 1, 2, 0.5, 0.5, 1, 1, 0.5, 1, 1])
        battleGrid[.psychic] = createRow(values: [1, 2, 1, 2, 1, 1, 1, 1, 0.5, 1, 1, 1, 1, 0.5, 1, 1, 0, 1])
        battleGrid[.ice] = createRow(values: [1, 1, 2, 1, 2, 1, 1, 1, 0.5, 0.5, 0.5, 2, 1, 1, 0.5, 2, 1, 1])
        battleGrid[.dragon] = createRow(values: [1, 1, 1, 1, 1, 1, 1, 1, 0.5, 1, 1, 1, 1, 1, 1, 2, 1, 0])
        battleGrid[.dark] = createRow(values: [1, 0.5, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 0.5, 0.5])
        battleGrid[.fairy] = createRow(values: [1, 2, 1, 0.5, 1, 1, 1, 1, 0.5, 0.5, 1, 1, 1, 1, 1, 2, 2, 1])

        return battleGrid
    }

    func createRow(values: [Float]) -> [PokemonType : Float] {
        assert(values.count == 18)
        var row = [PokemonType: Float]()

        for (index, type) in Self.types.enumerated() {
            row[type] = values[index]
        }

        return row
    }
}
