//
//  Pokemon.swift
//  PokeParty
//
//  Created by Jaroslaw Gliwinski on 2016-07-22.
//  Copyright © 2016 tooploox. All rights reserved.
//

import Foundation
import PokePartyShared


extension Pokemon {

    var name: String {
        return NSLocalizedString("p_\(number)", comment: "")
    }

    var image: UIImage {
        return UIImage(named: "pokemon_\(number)")!
    }
}


extension Pokemon: Hashable {

    public var hashValue: Int {
        return number
    }
}

public func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
    return lhs.number == rhs.number
}
