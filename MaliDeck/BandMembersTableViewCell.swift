//
//  BandMembersTableViewCell.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 15.11.16.
//  Copyright © 2016 Dmytro Pasinchuk. All rights reserved.
//

import UIKit

class BandMembersTableViewCell: UITableViewCell {

    @IBOutlet weak var bandMemberName: UILabel!
    @IBOutlet weak var bandMemberHillPoint: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.bandMemberName.textColor = UIColor.white
        self.bandMemberHillPoint.textColor = UIColor.white
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
