//
//  ViewController.swift
//  TipCalculator
//
//  Created by Ian Campelo on 9/28/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    @IBOutlet weak var divSlider: UISlider!
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblDivided: UILabel!
    @IBOutlet weak var lblTipResult: UILabel!
    @IBOutlet weak var tipSgControl: UISegmentedControl!
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var lblDividedResult: UILabel!
    var currencyString = ""
    var isValueRound = false
    var currencySymbol = "$"
    var currencyFormatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.toolbarValue()
        
        divSlider.addTarget(self, action: #selector(SettingsViewController.sliderValueChanged(_:)), forControlEvents: UIControlEvents.AllEvents)
        
        txtValue.addTarget(self, action: #selector(TipViewController._txtValue), forControlEvents: UIControlEvents.AllEvents)
        
        tipSgControl.addTarget(self, action: #selector(TipViewController.sgControlTouchDown(_:)), forControlEvents: UIControlEvents.AllEvents)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let round = defaults.boolForKey("round")
        let minV = defaults.floatForKey("minValue")
        let defaultV = defaults.floatForKey("defaultValue")
        let maxV = defaults.floatForKey("maxValue")
        
        let locale = NSLocale.currentLocale()
        currencySymbol = locale.objectForKey(NSLocaleCurrencySymbol)! as! String
        txtValue.placeholder = currencySymbol
        
        isValueRound = round;
        
        if(minV > 0){
            tipSgControl.setTitle(String(Int(minV))+"%", forSegmentAtIndex: 0)
        }
        if(defaultV > 0){
            tipSgControl.setTitle(String(Int(defaultV))+"%", forSegmentAtIndex: 1)
        }
        if(maxV > 0){
            tipSgControl.setTitle(String(Int(maxV))+"%", forSegmentAtIndex: 2)
        }
        if((Double(txtValue.text!)) != nil){
            calc()
        }
        currencyFormatter = NSNumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
    }
    
    //Make done button above the keyboard
    func toolbarValue(){
        let toolbar = UIToolbar.init()
        toolbar.sizeToFit()
        
        toolbar.items=[
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(TipViewController.closeKeyboard)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        ]
        
        txtValue.inputAccessoryView = toolbar
    }

    //Call calculation and subview (result)
    func _txtValue(){
        if((Double(txtValue.text!)) != nil){
            calc()
            showResultsView()
        }
        else{
            clearResultView()
        }
    }
    
    func closeKeyboard(){
        txtValue.resignFirstResponder()
    }
    
    func clearResultView(){
        self.resultView.alpha = 0
        lblResult.text = ""
    }
    
    //Show with animation the results view
    func showResultsView() {
        if(self.resultView.alpha == 0){
            UIView.animateWithDuration(0.7, animations: {
                self.resultView.alpha = 1
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    @IBAction func sgControlTouchDown(sender: UISegmentedControl) {
        if((Double(txtValue.text!)) != nil){
            calc()
            showResultsView()
        }
        else{
            clearResultView()
        }
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        divSlider.continuous = false
        
        
        
        let value = Int(divSlider.value)
        
        let tValue = currencyFormatter.stringFromNumber(Double(calc()/Double(value)))
        lblDividedResult.text = "Each one will pay \(tValue!)"
        
        var result = "Divided by \(value) "
        
        if(value <= 1){
            result += "person"
            lblDividedResult.hidden = true
        }
        else{
            result += "persons"
            lblDividedResult.hidden = false
        }
        lblDivided.text = result
    }
    
    //Method to make the calculation of the tips
    func calc() -> Double{
        let bill = Double(txtValue.text!)
        var value: String = tipSgControl.titleForSegmentAtIndex(tipSgControl.selectedSegmentIndex)!
        value = value.stringByReplacingOccurrencesOfString("%",withString: "")
        
        let tip = Double(value)
        
        let tipResult = bill! * tip!/100
        
        var total = tipResult + bill!
        if(isValueRound){
            total = (round(total)*100)/100
        }
        
        let cValue = currencyFormatter.stringFromNumber(total)
        lblResult.text = cValue!
        
        let tValue = currencyFormatter.stringFromNumber(tipResult)
        lblTipResult.text = tValue!
        return total
    }
}

