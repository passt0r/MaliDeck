//
//  CardViewController.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 06.11.16.
//  Copyright © 2016 Dmytro Pasinchuk. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var choosedMember: BandMembersTableViewCell!
    
    var bandMembers = [Stats]() //members in band
    var bandWounds = [Int]()
    let factions = [Fraction.guilde.rawValue, Fraction.arcanists.rawValue, Fraction.resurrectionists.rawValue, Fraction.neverborn.rawValue, Fraction.outcasts.rawValue, Fraction.tenThunders.rawValue, Fraction.gremlins.rawValue] //factions list, need for Picker View
    var selectedFaction: Fraction? = nil
    

    @IBOutlet weak var factionChoosingPicker: UIPickerView!
    //choosing game format
    @IBOutlet weak var choosedGameFormat: UISegmentedControl!
    var gameFormat = [35, 50, 75]
    @IBOutlet weak var chooseFractionTitleView: UIVisualEffectView!
    
    @IBOutlet weak var bandNameTitleView: UIVisualEffectView!
    func visualEffectForTitle(titleView: UIVisualEffectView) {
       /* let bilImageView = UIImageView(image: UIImage(named: "bil"))
        bilImageView.frame = titleView.bounds
        bilImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleView.insertSubview(bilImageView, at: 0)*/
        titleView.layer.cornerRadius = 20
        titleView.clipsToBounds = true
        titleView.backgroundColor = UIColor(colorLiteralRed: 0.1, green: 0.8, blue: 0.1, alpha: 0.6)
    }
    
    @IBOutlet weak var bandMembersTableView: UITableView!
    
    //overriding setEditing property for parent ViewController to add setEditing property to bandMemberTableView
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing == true {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        bandMembersTableView.setEditing(editing, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editButton = editButtonItem
        navigationItem.leftBarButtonItem = editButton
        // addSamples()
        //implement at first launch of DB, need for test
        
        
        visualEffectForTitle(titleView: chooseFractionTitleView)
        visualEffectForTitle(titleView: bandNameTitleView)
    
        bandMembersTableView.delegate = self
        bandMembersTableView.dataSource = self
        
        factionChoosingPicker.dataSource = self
        factionChoosingPicker.delegate = self
        
        selectedFaction = Fraction(rawValue: factions[0])
        
        
       let bilImageView = UIImageView(image: UIImage(named: "bil"))
        bilImageView.frame = UIScreen.main.bounds
        bandMembersTableView.backgroundColor = UIColor.clear
        bandMembersTableView.insertSubview(bilImageView, at: 0)
        
        bandMembersTableView.layer.cornerRadius = 10
        bandMembersTableView.clipsToBounds = true
        
        //implement custom view of tableView and pickerView
        factionChoosingPicker.layer.cornerRadius = 15
        factionChoosingPicker.clipsToBounds = true
        
        
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait //why it is not work?
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bandFiltration(by: Fraction) -> [Stats] {
        var filtratedBand = [Stats]()
        for member in bandMembers {
            if member.fraction == selectedFaction {
                filtratedBand.append(member)
            }
        }
        return filtratedBand
    }
    @IBAction func acceptButtonTouched(_ sender: UIButton) {
        bandMembers = bandFiltration(by: selectedFaction!)
        bandMembersTableView.reloadData()
    }
    //Getting data from AddingMembersTableViewController and prepare to insert data to band members table view
    @IBAction func unwindToAddingMemberViewTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddingMembersTableViewController, let bandMember = sourceViewController.bandMember /*getting data */{
            
            //adding new band member to your band
            let newBandMember = sourceViewController.bandMembers[bandMember]
            
            if !bandMembers.isEmpty {
                //checking new member faction
                if newBandMember.fraction != bandMembers[bandMembers.count - 1].fraction { //if faction did not mach to the band faction
                    sourceViewController.dismiss(animated: true, completion: {print("Adding invalid member")})
                    alert(reason: "Invalid member", message: "You can't adding member from \(newBandMember.fraction.rawValue) faction to \(bandMembers[bandMembers.count - 1].fraction.rawValue) band.")
                    return
                }
            }
            
            if bandMembers.isEmpty { //if you have no band
                if let newBandMember = newBandMember as? Master { //check of adding a master
                    
                } else { //if you did not have any master yet
                    sourceViewController.dismiss(animated: true, completion: {print("Dismiss to add some band master")})
                    alert(reason: "No master", message: "You did not have any band master yet, add someone.")
                    return
                }
            }
            
            if let newBandMember = newBandMember as? Master { //if user add master, check if band have other one
                for master in bandMembers {
                    if let master = master as? Master {
                        sourceViewController.dismiss(animated: true, completion: {print("Dismiss of reason of adding second band master")}) //dismiss adding view and show error massage after that
                        alert(reason: "Another master choosing", message: "In your band you have \(master.name), you can't add an other master") //showing error massage
                        //alert(reason: "Another master choosing", message: "In your band you have \(master.name), you can't add an other master")
                        return
                    }
                }
            }
            
             //checking price of new member and valid of adding him to band
            var summuryMembersPrice = 0
            for member in bandMembers {
                summuryMembersPrice += member.cost
            }
            summuryMembersPrice += newBandMember.cost
            for master in bandMembers { //finding band master's cash
                if let master = master as? Master {
                    let playerCash = gameFormat[choosedGameFormat.selectedSegmentIndex] + master.cash
                    if playerCash < summuryMembersPrice { //if new member too cost
                        sourceViewController.dismiss(animated: true, completion: {print("Dissmis of reason of overpricing")})
                        alert(reason: "Overprice", message: "Adding a new member is imposible, you need extra \(summuryMembersPrice - playerCash) soulstones")
                        return
                    }
                    
                }
            }
            let newIndexPath = IndexPath(row: bandMembers.count, section: 0)
            let memberLeftHits = newBandMember.wounds
            bandWounds.append(memberLeftHits) //add wounds for checking wounds that left
            bandMembers.append(newBandMember) //add member to array
            //insert data to tableview
            
            
            bandMembersTableView.insertRows(at: [newIndexPath], with: .bottom)
            
            
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddingNewCharacter" {
             let destinationNavigationController = segue.destination as! UINavigationController
             let destinationViewController = destinationNavigationController.topViewController as! AddingMembersTableViewController
            destinationViewController.selectedFaction = selectedFaction
        } else if segue.identifier == "showStatCards" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let destinationViewController = destinationNavigationController.topViewController as! StatCardViewController
            guard let selectedMember = sender as? BandMembersTableViewCell else { fatalError("Error with choosing member")}
            guard let indexforMember = bandMembersTableView.indexPath(for: selectedMember)  else { fatalError("Error with finding index") }
            let choosingMember = bandMembers[indexforMember.row]
            destinationViewController.currentMember = choosingMember
            guard let hitLeft = Int(selectedMember.bandMemberHillPoint.text!) else { fatalError("Cannot convert hillPoint to int") }
            destinationViewController.hitsLeft = hitLeft
        }
    }
    
    @IBAction func unwindToStatCard(sender: UIStoryboardSegue) {
        guard let statCardController = sender.source as? StatCardViewController else {  fatalError("Unexpected sender for unwindToStatCard()") }
        let newHills = statCardController.hitsLeft
        guard let indexOfSelectedRow = bandMembersTableView.indexPathForSelectedRow else { fatalError("Can't find selected row for update data") }
        /*let selectedRow = bandMembersTableView.cellForRow(at: indexOfSelectedRow) as! BandMembersTableViewCell
        selectedRow.bandMemberHillPoint.text = String(newHills)*/
        //bandMembers[indexOfSelectedRow.row].wounds = newHills
        bandWounds[indexOfSelectedRow.row] = newHills
        bandMembersTableView.reloadRows(at: [indexOfSelectedRow], with: .automatic)
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of row in section
        return bandMembers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat.init(50)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BandMember", for: indexPath) as! BandMembersTableViewCell
        
        cell.bandMemberName.text = bandMembers[indexPath.row].name
        cell.bandMemberHillPoint.text = String(bandWounds[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bandMembers.remove(at: indexPath.row)
            bandWounds.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true 
    }
    
    
    
    //error massage
   func alert(reason: String, message: String) {
        let alert = UIAlertController(title: reason, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok, go next", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {print("Error displayed on Card View Controller")})
    }
    
    //MARK: picker view controll
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return factions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return factions[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFaction = Fraction(rawValue: factions[row])
    }
    

}

