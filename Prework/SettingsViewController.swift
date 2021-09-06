//
//  SettingsViewController.swift
//  Prework
//
//  Created by Matthew Peng on 8/31/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var darkModeSwitch: UISwitch!
    @IBOutlet weak var customTip: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            darkModeSwitch.isOn = true
        } else {
            overrideUserInterfaceStyle = .light
        }
        let customTipText = String(format: "%.2f", defaults.double(forKey: "customTip"))
        customTip.text = customTipText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = UserDefaults.standard
        let customTip = Double(customTip.text!) ?? defaults.double(forKey: "customTip")
        if customTip >= 0 {
            defaults.set(customTip, forKey: "customTip")
            defaults.set(true, forKey: "customTipChanged")
            defaults.synchronize()
        } else {
            defaults.set(false, forKey: "customTipChanged")
        }
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        if sender.isOn {
            defaults.set(true, forKey: "darkModeState")
            overrideUserInterfaceStyle = .dark
        } else {
            defaults.set(false, forKey: "darkModeState")
            overrideUserInterfaceStyle = .light
        }
        defaults.synchronize()
    }
    
}
