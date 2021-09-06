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
    @IBOutlet weak var splitBillControl: UISwitch!
    @IBOutlet weak var numInPartyLabel: UILabel!
    @IBOutlet weak var numInPartyTextField: UITextField!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var totalPerPersonResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tip Calculator"
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
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
            calculateTip(UIButton())
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
        
        calculateSplitBill(UIButton())
    }
    
    @IBAction func splitBill(_ sender: UISwitch) {
        if splitBillControl.isOn {
            numInPartyLabel.isHidden = false
            numInPartyTextField.isHidden = false
            numInPartyTextField.isEnabled = true
            totalPerPersonLabel.isHidden = false
            totalPerPersonResult.isHidden = false
        } else {
            numInPartyLabel.isHidden = true
            numInPartyTextField.isHidden = true
            numInPartyTextField.isEnabled = false
            totalPerPersonLabel.isHidden = true
            totalPerPersonResult.isHidden = true
        }
    }
    
    @IBAction func calculateSplitBill(_ sender: Any) {
        var numToSplit = Int(numInPartyTextField.text!) ?? 1
        if numToSplit == 0 {
            numToSplit = 1
        }
        numInPartyTextField.text = String(numToSplit)
        var value = String(totalLabel.text!)
        value.removeFirst()
        let bill = Double(value) ?? 0
        let totalPerPerson = bill / Double(numToSplit)
        totalPerPersonResult.text = String(format: "$%.2f", totalPerPerson)
    }
    
}

