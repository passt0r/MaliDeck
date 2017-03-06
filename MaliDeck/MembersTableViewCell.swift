//
//  MembersTableViewCell.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 12.11.16.
//  Copyright © 2016 Dmytro Pasinchuk. All rights reserved.
//

import UIKit

class MembersTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var memberCellView: UIView!
    
    @IBOutlet weak var memberPhoto: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberFaction: UILabel!
    @IBOutlet weak var memberCoastOrCash: UILabel!
    @IBOutlet weak var coastOrCashLabel: UILabel!
    
    @IBOutlet weak var nameStack: UIStackView!
    @IBOutlet weak var factionStack: UIStackView!
    @IBOutlet weak var costStack: UIStackView!
    
    
    //MARK: Member properties on stack, NOT USED!
   
    @IBOutlet weak var memberPropertyStack: UIStackView!
    
    @IBOutlet weak var dfStack: UIStackView!
    @IBOutlet weak var wpStack: UIStackView!
    @IBOutlet weak var wdStack: UIStackView!
    @IBOutlet weak var wkStack: UIStackView!
    @IBOutlet weak var cgStack: UIStackView!
    @IBOutlet weak var htStack: UIStackView!
    
    //Not used, did not working, wiil be used in future for creating table-like borders
   /* func borderInit(stack: UIStackView) {
        
        let borderView = UIView(frame: stack.frame)
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.clipsToBounds = true
        stack.addArrangedSubview(borderView)
        
        
    } */
    
    
    //MARK: Members ptoperties
    @IBOutlet weak var dfCount: UILabel!
    @IBOutlet weak var wpCount: UILabel!
    @IBOutlet weak var wdCount: UILabel!
    @IBOutlet weak var wkCount: UILabel!
    @IBOutlet weak var cgCount: UILabel!
    @IBOutlet weak var htCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //let stackArray: [UIStackView] = [nameStack, factionStack, costStack, memberPropertyStack, dfStack, wpStack, wdStack, wkStack, cgStack, htStack]
       /* for stack in stackArray {
            borderInit(stack: stack) //init borders to all stack
        }
        */
        
        memberPhoto.layer.borderWidth = 1
        memberPhoto.layer.borderColor = UIColor.black.cgColor
        
        //MARK: Cell image properties
        memberCellView.backgroundColor = UIColor.clear
        let paperView = UIImageView(image: UIImage(named: "paper"))
        paperView.frame = memberCellView.bounds
        paperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        paperView.layer.cornerRadius = 8
        paperView.clipsToBounds = true
        memberCellView.insertSubview(paperView, at: 0)
        
        

        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
