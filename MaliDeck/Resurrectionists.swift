//
//  Resurrectionists.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 15.11.16.
//  Copyright © 2016 Dmytro Pasinchuk. All rights reserved.
//

import Foundation
import UIKit


let mcMourning = Master(name: "McMourning", fraction: .resurrectionists, photo: UIImage(named: "mcMourningFace"), cash: 4, wounds: 14, def: 5, will: 5, walk: 5, cg: 7, hit: 2, firstStatCard: UIImage(named: "mcMourningStats")!, secondStatCard: UIImage(named: "mcMourningBack")!)
let nurce = Stats(name: "Nurce", fraction: .resurrectionists, photo: UIImage(named: "nurceFace"), cost: 5, wounds: 6, def: 4, will: 6, walk: 4, cg: 6, hit: 2, firstStatCard: UIImage(named: "nurseStats")!, secondStatCard: UIImage(named: "nurseBack")!)

func prepareResurrectionists() -> [Stats] {
    var resurrsMembers = [Stats]()
    resurrsMembers = prepareDownload(fraction: "Resurrectionists")
    
    //resurrsMembers.append(mcMourning)
    //resurrsMembers.append(nurce)
    
    return resurrsMembers
    
}
