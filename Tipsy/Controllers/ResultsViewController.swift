//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Jan Lewandowski on 13/04/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var totalValue: Float?
    var settings: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalLabel.text = String(totalValue!)
        settingsLabel.text = settings!
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
