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

        let (goodDefenseTypes, badDefenseTypes) = getDefenseTypes(for: opponent)
        let (goodAttackTypes, badAttackTypes) = getAttackTypes(for: opponent)
        let (goodTypes, badTypes) = resolvedGoodAndBadTypes(goodAttackTypes: goodAttackTypes,
                                                            badAttackTypes: badAttackTypes,
                                                            goodDefenseTypes: goodDefenseTypes,
                                                            badDefenseTypes: badDefenseTypes)

        return BattleAdvice(goodTypes: goodTypes, badTypes: badTypes)
    }
}

private extension PokemonBattleAdvisor {

    private func resolvedGoodAndBadTypes(goodAttackTypes: [TypeEffectiveness],
                                            badAttackTypes: [TypeEffectiveness],
                                            goodDefenseTypes: [TypeEffectiveness],
                                            badDefenseTypes: [TypeEffectiveness]) -> (good: [PokemonType],
                                                                                      bad: [PokemonType]) {
        var badTypes = badAttackTypes.map { $0.type }
        badTypes.append(contentsOf: badDefenseTypes.map { $0.type })

        //Move types that occur more than once to the top
        badTypes = consolidatePopularTypes(badTypes)

        var goodTypes = goodDefenseTypes.map({ $0.type })
        goodTypes.append(contentsOf: goodAttackTypes.map({ $0.type }))

        //Move types that occur more than once to the top
        goodTypes = consolidatePopularTypes(goodTypes)

        //take any bad types out of the good
        goodTypes = goodTypes.filter { badTypes.contains($0) == false }

        return (goodTypes, badTypes)
    }

    private func consolidatePopularTypes(_ types: [PokemonType]) -> [PokemonType] {

        return types.reduce([PokemonType: Int](), { result, type in
                                var newResult = result
                                newResult[type] = result[type] ?? 0
                                newResult[type]! += 1
                                return newResult })
                    .map { return (type: $0, value: $1) }
                    .sorted { $0.value > $1.value }
                    .map { $0.type }
    }


    private func getAttackTypes(for opponent: Pokemon) -> (good: [TypeEffectiveness],
                                                           bad: [TypeEffectiveness]) {
        var goodAttackTypes = [TypeEffectiveness]()
        var badAttackTypes = [TypeEffectiveness]()

        for type in Self.types {
            if let attackEffectiveness = attackGrid[type] {
                for (defenseType, effectiveness) in attackEffectiveness {
                    if opponent.types.contains(defenseType) {
                        if effectiveness > 1 {
                            //This type is effective in attacking them
                            goodAttackTypes.append(TypeEffectiveness(type: defenseType, value: effectiveness))
                        } else if effectiveness < 1 {
                            //This type sucks
                            badAttackTypes.append(TypeEffectiveness(type: defenseType, value: effectiveness))
                        }
                    }
                }
            }
        }

        badAttackTypes.sort { $0.value < $1.value }

        return (goodAttackTypes, badAttackTypes)
    }

    private func getDefenseTypes(for opponent: Pokemon) -> (good: [TypeEffectiveness],
                                                            bad: [TypeEffectiveness])  {
        var goodDefenseTypes = [TypeEffectiveness]()
        var badDefenseTypes = [TypeEffectiveness]()

        for type in Self.types {
            if opponent.types.contains(type) {
                if let attackEffectiveness = attackGrid[type] {
                    for (attackType, effectiveness) in attackEffectiveness {
                        if effectiveness > 1 {
                            //They have elevated attacks against these types
                            badDefenseTypes.append(TypeEffectiveness(type: attackType, value: effectiveness))
                        } else if effectiveness < 1 {
                            //they have reduced attacks against these types
                            goodDefenseTypes.append(TypeEffectiveness(type: attackType, value: effectiveness))
                        }
                    }
                }
            }
        }

        goodDefenseTypes.sort { $0.value < $1.value }

        return (goodDefenseTypes, badDefenseTypes)
    }

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
