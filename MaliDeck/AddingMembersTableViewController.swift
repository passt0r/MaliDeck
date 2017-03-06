//
//  AddingMembersTableViewController.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 12.11.16.
//  Copyright © 2016 Dmytro Pasinchuk. All rights reserved.
//

import UIKit

class AddingMembersTableViewController: UITableViewController {
    
    var unfilteredBandMembers = [Stats]()
    var bandMembers = [Stats]()
    var bandMember: Int? = nil
    var selectedFaction: Fraction? = nil
    


    @IBAction func cancelAdding(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: {print("Cancel adding new member")})
    }
    
    //MARK: Add Samples
    func addMembers() {
       
        unfilteredBandMembers.append(contentsOf: prepareGuild())
        unfilteredBandMembers.append(contentsOf: prepareResurrectionists())
        unfilteredBandMembers.append(contentsOf: prepareArcanists())
        unfilteredBandMembers.append(contentsOf: prepareNeverborn())
        unfilteredBandMembers.append(contentsOf: prepareTenThunders())
        unfilteredBandMembers.append(contentsOf: prepareGremlins())
        unfilteredBandMembers.append(contentsOf: prepareOutcasts())
        
    }
    
    //TODO: create new file, in wich new members of band will be created and writing on a disk, and in this viewDidLoad this file will be readed and new members will be added to [bandMembers]
    //TODO: create method in wich after image will be touched, this member will be added to main card screen
    
    func filtratedBandMembers(by: Fraction) -> [Stats] {
        var filtratedBandMembers = [Stats]()
        for member in unfilteredBandMembers {
            if member.fraction == selectedFaction {
                filtratedBandMembers.append(member)
            }
        }
        return filtratedBandMembers
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "malifaux_main"))
        addMembers()
        
        bandMembers = filtratedBandMembers(by: selectedFaction!)
        
        
        
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bandMembers.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat.init(200)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddingNewMemberCell", for: indexPath) as! MembersTableViewCell
        let member = bandMembers[indexPath.row]
        
        cell.memberPhoto.image = member.photo
        cell.memberName.text = member.name
        cell.memberFaction.text = member.fraction.rawValue
        cell.wdCount.text = String(member.wounds)
        cell.dfCount.text = String(member.def)
        cell.wpCount.text = String(member.willPow)
        cell.wkCount.text = String(member.walk)
        cell.cgCount.text = String(member.cg)
        cell.htCount.text = String(member.hit)
        
        if let member = member as? Master {
            cell.coastOrCashLabel.text = "Cash"
            cell.memberCoastOrCash.text = String(member.cash)
        } else {
            cell.coastOrCashLabel.text = "Coast"
            cell.memberCoastOrCash.text = String(member.cost)
        }
        
        

        return cell
    }
    
    
    //MARK: Recognise user interaction (tap on image to add member to the band)
    
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedMemberCell = sender as? MembersTableViewCell {
            
            bandMember = tableView.indexPath(for: selectedMemberCell)!.row
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //error massage
    func alert(reason: String, message: String) {
        let alert = UIAlertController(title: reason, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok, go next", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {print("Error displayed on Adding member view controller")})
    }
    

}
