//
//  Array+Safe.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 1/31/21.
//

import Foundation

extension Array {

    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
