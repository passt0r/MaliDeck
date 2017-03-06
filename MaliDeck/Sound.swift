//
//  Sound.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 07.11.16.
//  Copyright © 2016 Dmytro Pasinchuk. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Sound {
    var name: String
    init(name: String) {
        self.name = name.lowercased()
    }
}
