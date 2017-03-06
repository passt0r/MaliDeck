//
//  Guild.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 07.02.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


//samples
let guildMcMourning = Master(name: "McMourning", fraction: .guilde, photo: UIImage(named: "mcMourningFace"), cash: 4, wounds: 14, def: 5, will: 5, walk: 5, cg: 7, hit: 2, firstStatCard: UIImage(named: "mcMourningStats")!, secondStatCard: UIImage(named: "mcMourningBack")!)
let guildNurce = Stats(name: "Nurce", fraction: .guilde, photo: UIImage(named: "nurceFace"), cost: 5, wounds: 6, def: 4, will: 6, walk: 4, cg: 6, hit: 2, firstStatCard: UIImage(named: "nurseStats")!, secondStatCard: UIImage(named: "nurseBack")!)

func prepareGuild() -> [Stats] {
    var guildMembers = [Stats]()
    guildMembers = prepareDownload(fraction: "The Guild")
    
    //guildMembers.append(guildMcMourning)
    //guildMembers.append(guildNurce)
    
    return guildMembers
    
}
