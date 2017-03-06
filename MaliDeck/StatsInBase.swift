//
//  StatsInBase.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 06.03.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import Foundation
import RealmSwift

class StatsInBase: Object {
    
    dynamic var name = ""
    dynamic var fraction = ""
    dynamic var photoName = ""
    dynamic var cost = 0
    
    dynamic var wounds = 0
    dynamic var def = 0
    dynamic var willPow = 0
    dynamic var walk = 0
    dynamic var cg = 0
    dynamic var hit = 0
    
    dynamic var firstStatCardName = ""
    dynamic var secondStatCardName = ""
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

class MasterInBase: Object {
    
    dynamic var name = ""
    dynamic var fraction = ""
    dynamic var photoName = ""
    dynamic var cash = 0
    
    dynamic var wounds = 0
    dynamic var def = 0
    dynamic var willPow = 0
    dynamic var walk = 0
    dynamic var cg = 0
    dynamic var hit = 0
    
    dynamic var firstStatCardName = ""
    dynamic var secondStatCardName = ""
    
}
