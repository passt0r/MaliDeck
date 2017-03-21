//
//  DownloadFromRealm.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 06.03.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

func prepareDownload(fraction: String) -> [Stats] {
    
    var newMembers = [Stats]()
    
    let realmParth = Bundle.main.path(forResource: "default 3", ofType: "realm")
    
    var realmConfig = Realm.Configuration()
    if let realmParth = realmParth {
        realmConfig.fileURL = URL(fileURLWithPath: realmParth)
    } else {
        fatalError("Can't read data from default realm")
    }
    realmConfig.readOnly = true
    
    
    let realm = try! Realm(configuration: realmConfig)
    
    let mastersInBase = realm.objects(MasterInBase.self).filter("fraction = '\(fraction)'")
    let membersInBase = realm.objects(StatsInBase.self).filter("fraction = '\(fraction)'")
    
    //adding master from the Realm to string
    for master in mastersInBase {
        let name = master.name
        let fraction = Fraction(rawValue: fraction)!
        let photo = UIImage(named: master.photoName)
        let cash = master.cash
        let wounds = master.wounds
        let def = master.def
        let will = master.willPow
        let  walk = master.walk
        let cg = master.cg
        let hit = master.hit
        
        guard let firstStatCardImage = UIImage(named: master.firstStatCardName) else { continue }
        guard let secondStatCardImage = UIImage(named: master.secondStatCardName) else { continue }
        
        let newMaster = Master(name: name, fraction: fraction, photo: photo, cash: cash, wounds: wounds, def: def, will: will, walk: walk, cg: cg, hit: hit, firstStatCard: firstStatCardImage, secondStatCard: secondStatCardImage)
        newMembers.append(newMaster)
        
    }
    
    //adding members from the Realm to string
    for member in membersInBase {
        let name = member.name
        let fraction = Fraction(rawValue: fraction)!
        let photo = UIImage(named: member.photoName)
        let cost = member.cost
        let wounds = member.wounds
        let def = member.def
        let will = member.willPow
        let  walk = member.walk
        let cg = member.cg
        let hit = member.hit
        
        guard let firstStatCardImage = UIImage(named: member.firstStatCardName) else { continue }
        guard let secondStatCardImage = UIImage(named: member.secondStatCardName) else { continue }
        
        let newMember = Stats(name: name, fraction: fraction, photo: photo, cost: cost, wounds: wounds, def: def, will: will, walk: walk, cg: cg, hit: hit, firstStatCard: firstStatCardImage, secondStatCard: secondStatCardImage)
        newMembers.append(newMember)
        
    }
    
    return newMembers
}
