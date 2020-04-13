//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var twentyButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip: Float = 0.1
    var splitNumber: Int = 2
    var billValue: Double = 0.0
    var finalValue: Float = 0.0
    var tipString: String = "10"
    var settings: String = "Split between 2 people, with 10% tip"
    
    // pressed any button with tip percentage
    @IBAction func tipChanged(_ sender: UIButton) {
        // hide keyboard when clicked out of it
        billTextField.endEditing(true)
        
        // keyboard appears with only numbers when using text field
        billTextField.keyboardType = UIKeyboardType.decimalPad
        
        // select only last clicked button
        zeroButton.isSelected = false
        tenButton.isSelected = false
        twentyButton.isSelected = false
        sender.isSelected = true
        
        // get the tip value from buttons
        let buttonTitle: String? = sender.currentTitle
        tipString = String(buttonTitle?.dropLast() ?? "0.0")
        guard let tipPct = Float(tipString) else { return }
        tip = tipPct / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // hide keyboard when clicked out of it
        billTextField.endEditing(true)
        
        // get number of people from stepper
        splitNumber = Int(sender.value)
        
        // update stepper label
        splitNumberLabel.text = String(splitNumber)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        // get the bill value from text field
        let billText: String = billTextField.text ?? "0.0"
        billValue = Double(billText.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        
        //calculate final value per person
        let finalValueUnrounded = (Float(billValue) + Float(billValue) * tip) / Float(splitNumber) * 100
        finalValue = finalValueUnrounded.rounded() / 100
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    // hide keyboard when clicked out of it
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        billTextField.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalValue = finalValue
            destinationVC.settings = "Split between \(splitNumber) people, with \(tipString)% tip"
        }
    }

}

