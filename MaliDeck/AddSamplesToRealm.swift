//
//  AddSamplesToRealm.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 06.03.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

func addSamples() {
    
    let baseMcMourning = MasterInBase()
    baseMcMourning.name = "McMourning"
    baseMcMourning.fraction = "The Guild"
    baseMcMourning.photoName = "mcMourningFace"
    baseMcMourning.cash = 4
    baseMcMourning.wounds = 14
    baseMcMourning.def = 8
    baseMcMourning.willPow = 5
    baseMcMourning.walk = 5
    baseMcMourning.cg = 7
    baseMcMourning.hit = 2
    baseMcMourning.firstStatCardName = "mcMourningStats"
    baseMcMourning.secondStatCardName = "mcMourningBack"
    
    
    let baseNurce = StatsInBase()
    baseNurce.name = "Nurce"
    baseNurce.fraction = "Resurrectionists"
    baseNurce.photoName = "nurceFace"
    baseNurce.cost = 5
    baseNurce.wounds = 6
    baseNurce.def = 4
    baseNurce.willPow = 6
    baseNurce.walk = 4
    baseNurce.cg = 6
    baseNurce.hit = 2
    baseNurce.firstStatCardName = "nurseStats"
    baseNurce.secondStatCardName = "nurseBack"
    
    
    let realm = try! Realm()
    
    try! realm.write {
        realm.add(baseMcMourning)
        realm.add(baseNurce)
    }
    
}
