//
//  ViewController.swift
//  TipCalculator
//
//  Created by Ian Campelo on 9/28/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var txtTip: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnCalc(sender: AnyObject) {
        var tip = Double(txtTip.text!)
        var bill = Double(txtValue.text!)
        
        var tipResult = bill! * tip!/100
        
        var total = tipResult + bill!
        
        lblResult.text = "Tip + bill: ${total}"
        
    }
    

}

