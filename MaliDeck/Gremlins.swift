//
//  Gremlins.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 07.02.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import Foundation
import UIKit

func prepareGremlins() -> [Stats] {
    var gremlinsMembers = [Stats]()
    gremlinsMembers = prepareDownload(fraction: "Gremlins")
    
    
    return gremlinsMembers
    
}
