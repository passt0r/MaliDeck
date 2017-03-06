//
//  SecondPageStatsViewController.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 10.02.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit

class SecondPageStatsViewController: UIViewController {
    @IBOutlet weak var statCardImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let conteiner = self.parent as? StatCardViewController else { fatalError("Unexpected conteiner for secondPageViewController") }
        guard let member = conteiner.currentMember else { fatalError("Can't read data from parent") }
        
        statCardImage.image = member.secondStatCard

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
