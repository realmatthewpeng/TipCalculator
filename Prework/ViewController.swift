//
//  ViewController.swift
//  Prework
//
//  Created by Matthew Peng on 8/30/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tip Calculator"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "darkModeState") == true {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        if defaults.bool(forKey: "customTipChanged") {
            let customTip = String(format: "%.0f", defaults.double(forKey: "customTip"))
            tipControl.setTitle(customTip + "%", forSegmentAt: 3)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
     
    @IBAction func calculateTip(_ sender: Any) {
        // get bill amount from text field
        let bill = Double(billAmountTextField.text!) ?? 0
        
        // get total tip
        let defaults = UserDefaults.standard
        let tipPercentages = [0.15, 0.18, 0.2, defaults.double(forKey: "customTip")/100]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        // update tip amount label
        tipAmountLabel.text = String(format: "$%.2f", tip)
        
        // update total amount
        totalLabel.text = String(format: "$%.2f", total)
    }
    
}

