//
//  Outcasts.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 07.02.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import Foundation
import UIKit

func prepareOutcasts() -> [Stats] {
    var outcastsMembers = [Stats]()
    outcastsMembers = prepareDownload(fraction: "Outcasts")
    
    
    return outcastsMembers
    
}
