//
//  HitStackView.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 16.02.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit


@IBDesignable class HitStackView: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable var availableHits: Int = 14 {
        didSet {
            setupButtons()
        }
    }
    var hitsLeft = 0 {
        didSet {
            updateButtonStages()
        }
    }//hits that left and all available hits (take data from cardViewController table View)
    
    var buttons = [UIButton]()     //all available buttons
    
    @IBInspectable var buttonSize: CGSize = CGSize(width: 20, height: 17) {
        didSet {
            setupButtons()
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button actoins 
    func touched(button: UIButton) {
    guard let buttonIndex = buttons.index(of: button) else { fatalError("Unexpected button was touched") }
    
    let hits = buttonIndex + 1
    
        if(hitsLeft == availableHits - 1) && (buttonIndex == 0) {
            hitsLeft = availableHits
        } else {
            hitsLeft = availableHits - hits
        }
        
    }
    
    private func updateButtonStages() {
        for (index, buttton) in buttons.enumerated() {
            let highlitedButtons = availableHits - hitsLeft
            buttton.isSelected = index < highlitedButtons
        }
        
    }
    
    //MARK: Hit buttons
    private func setupButtons() {
        //clear all buttons that can be before start setup
        for button in buttons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        buttons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let hited = UIImage(named: "hited", in: bundle, compatibleWith: self.traitCollection)
        let notHited = UIImage(named: "not_hited", in: bundle, compatibleWith: self.traitCollection)
        
        //generate all buttons
        for index in 0..<availableHits {
        let button = UIButton() //generate button
        button.setImage(notHited, for: .normal)
        button.setImage(hited, for: .selected)      //added images for all posible stages
        button.setImage(hited, for: .highlighted)
        button.setImage(hited, for: [.highlighted, .selected])
        
        // set constraints to the generated buttons
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
        
        // set accebility Label for button
        button.accessibilityLabel = "Take \(index + 1) wounds"
            
        //add action event for button
        button.addTarget(self, action: #selector(HitStackView.touched(button:)), for: .touchUpInside)
        
        //add button to the StackView
        addArrangedSubview(button)
        
        //add button to the array of buttons
        buttons.append(button)
        }
    }

}
