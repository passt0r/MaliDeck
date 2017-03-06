//
//  Stats.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 11.11.16.
//  Copyright © 2016 Dmytro Pasinchuk. All rights reserved.
//

import UIKit
//Also need to add binded stat cards to the Stats class or insert Stats objects in cards
enum Fraction: String {
    
    case guilde = "The Guild"
    case resurrectionists = "Resurrectionists"
    case neverborn = "Neverborn"
    case arcanists = "Arcanists"
    case outcasts = "Outcasts"
    case tenThunders = "Ten Thunders"
    case gremlins = "Gremlins"
    
}
//TODO: Adding an emplementation of stat cards for each object

class Stats {
    //MARK: Properties
    var name: String
    var fraction: Fraction
    var photo: UIImage?
    var cost: Int
    
    var wounds: Int
    var def: Int
    var willPow: Int
    var walk: Int
    var cg: Int
    var hit: Int
    
    var firstStatCard: UIImage
    var secondStatCard: UIImage
    
    init(name: String, fraction: Fraction, photo: UIImage?, cost: Int, wounds: Int, def: Int, will: Int, walk: Int, cg: Int, hit: Int, firstStatCard: UIImage, secondStatCard: UIImage) {
        self.name = name
        self.fraction = fraction
        self.cost = cost
        if photo == nil {
            self.photo  = UIImage(named: "no_photo")
        } else {
            self.photo = photo
        }
        
        self.wounds = wounds
        self.def = def
        self.willPow = will
        self.walk = walk
        self.cg = cg
        self.hit = hit
        
        self.firstStatCard = firstStatCard
        self.secondStatCard = secondStatCard
        
    }
}

class Master: Stats {
    var cash: Int
    init(name: String, fraction: Fraction, photo: UIImage?, cash: Int, wounds: Int, def: Int, will: Int, walk: Int, cg: Int, hit: Int, firstStatCard: UIImage, secondStatCard: UIImage) {
        
        self.cash = cash
        super.init(name: name, fraction: fraction, photo: photo, cost: 0, wounds: wounds, def: def, will: will, walk: walk, cg: cg, hit: hit, firstStatCard: firstStatCard, secondStatCard: secondStatCard)
        
    }
}


