//
//  SoundTableViewController.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 07.11.16.
//  Copyright © 2016 Dmytro Pasinchuk. All rights reserved.
//

import UIKit
import AVFoundation

class SoundTableViewController: UITableViewController, UINavigationBarDelegate {
    
    @IBAction func returnToStats(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: {print("Return to stats")})
    }
    
    
    //MARK: Properties
    
    var sounds = [Sound]()
    var newSounds = [String]()
    
    //Sound player, play sounds while play button has been touched
    var player: AVAudioPlayer?
    func play(button: UIButton) {
        let buttonTag = button.tag
        let sound = sounds[buttonTag].name
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
            return
        }
        
    }
    //alert if sound was not found
    func alert(sound: String) {
        let alert = UIAlertController(title: "Player error", message: "Sound with name \(sound) was not found and will be added soon", preferredStyle: .alert)
        alert.addAction(.init(title: "Ok, go next", style: .default, handler: nil))
        //  if let input = inputController { input.present(alert, animated: true, completion: {print("Error displayed")}) }
        self.present(alert, animated: true, completion: {print("Player error displayed")})
    }
    
    //adding aditional sounds
    
    func addingNewSounds(named soundlist: [String]) {
        for sound in soundlist {
            sounds.append(Sound.init(name: sound))
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "malifaux_main"))
        
        //loadSamples()
        //if you want to add some new rows, patch and uncomment next lines
        newSounds += ["walk", "shoot", "melee", "cast", "summon", "hit", "blast", "fail", "killed"]
        addingNewSounds(named: newSounds)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sounds.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         // Configuring the cell
        
        let cellId = "SoundViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SoundTableViewCell
        
        let sound = sounds[indexPath.row]
        
        cell.soundName.text = sound.name
        
        cell.playButton.tag = indexPath.row
        
        cell.playButton.addTarget(self, action: #selector(SoundTableViewController.play(button:)), for: .touchDown)

        return cell
    }
    
    //MARK: Loading samples
    func loadSamples() {
        let walk = Sound(name: "walk")
        let shoot = Sound(name: "shoot")
        let melee = Sound(name: "melee")
        
        sounds += [walk, shoot, melee]
    
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
