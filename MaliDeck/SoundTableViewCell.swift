//
//  SoundTableViewCell.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 07.11.16.
//  Copyright © 2016 Dmytro Pasinchuk. All rights reserved.
//

import UIKit
import AVFoundation

class SoundTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var soundView: UIView!
    @IBOutlet weak var soundName: UILabel!
    @IBOutlet weak var playButton: UIButton!
    //var sound = String() //sound name, use for player, not used - played transfer to controller
   // var inputController: SoundTableViewController? = nil //present view controller, uses reference to super view controller for showing massage; not used - player don't work in this file
    
    //bluring soundView
    func makeVisualEffect(view: UIView) {
        
       let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.clipsToBounds = true
        view.insertSubview(blurEffectView, at: 0)
        //fix showing
        
    }
    /*
    //Player action
    var player: AVAudioPlayer?
    func play(button: UIButton) {
        print("Button \(sound) touched")
        guard let url = Bundle.main.url(forResource: sound, withExtension: "m4a")
            else {
               alert(sound: sound)
                return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else {
                alert(sound: sound)
                return
            }
            player.prepareToPlay()
            player.play()
        } catch let error as Error {
            alert(sound: sound)
            return //false
        }
        
    }
 */
    
    
    
    
   /* func alert(sound: String) {
        let alert = UIAlertController(title: "Player error", message: "Sound with name\(sound) not found and will be added soon", preferredStyle: .alert)
        alert.addAction(.init(title: "Ok, go next", style: .default, handler: nil))
      //  if let input = inputController { input.present(alert, animated: true, completion: {print("Error displayed")}) }
       // self.present(alert, animated: true, completion: {print("Error displayed")})
    } */
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeVisualEffect(view: soundView)
        
      //  playButton.addTarget(self, action: #selector(SoundTableViewCell.play(button:)), for: .touchDown)//add player action in button
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
