//
//  ViewController.swift
//  TipCalculator
//
//  Created by Ian Campelo on 9/28/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    @IBOutlet weak var txtValue: UITextField!
//    @IBOutlet weak var txtTip: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var tipSgControl: UISegmentedControl!
    @IBOutlet weak var resultView: UIView!
    var currencyString = ""
//    override func viewWillAppear(animated: Bool) {
//        resultView.hidden = true
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toolbarValue()
//        self.toolbarTip()
        
    }
    func toolbarValue(){
        let toolbar = UIToolbar.init()
        toolbar.sizeToFit()
        
        toolbar.items=[
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(TipViewController._txtValue)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        ]
        
        txtValue.inputAccessoryView = toolbar
    }

    
//    func toolbarTip(){
//        let toolbar = UIToolbar.init()
//        toolbar.sizeToFit()
//        
//        toolbar.items=[
//            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(TipViewController._txtTip)),
//            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//        ]
//        
//        txtTip.inputAccessoryView = toolbar
//    }
    
    @IBAction func txtValueDidBegin(sender: UITextField) {
        switch sender.text! {
            case "0","1","2","3","4","5","6","7","8","9":
                currencyString += sender.text!
                formatCurrency(&currencyString)
            default:
                let array = Array(arrayLiteral: sender.text!)
                var currentStringArray = Array(arrayLiteral: currencyString)
                if array.count == 0 && currentStringArray.count != 0 {
                    currentStringArray.removeLast()
                    currencyString = ""
                    for character in currentStringArray {
                        currencyString += String(character)
                    }
                    formatCurrency(&currencyString)
                }
        }
    }
    func _txtValue(){
        //txtTip.becomeFirstResponder()
        if((Double(txtValue.text!)) != nil){
          //  txtTip.resignFirstResponder()
            calc()
            showResultsView()
        }
    }
    
    func showResultsView() {
        resultView.hidden = false
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.resultView.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
        
    }
    
//    func _txtTip(){
//        if((Double(txtValue.text!)) == nil){
//            txtValue.becomeFirstResponder()
//        }
//        else{
//            txtTip.resignFirstResponder()
//            calc()
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func txtField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            currencyString += string
            formatCurrency(&currencyString)
        default:
            let array = Array(arrayLiteral: string)
            var currentStringArray = Array(arrayLiteral: currencyString)
            if array.count == 0 && currentStringArray.count != 0 {
                currentStringArray.removeLast()
                currencyString = ""
                for character in currentStringArray {
                    currencyString += String(character)
                }
                formatCurrency(&currencyString)
            }
        }
        return false
    }
    
    func formatCurrency(inout string: String) {
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        let locale = NSLocale.currentLocale()
        formatter.locale = locale.objectForKey(NSLocaleCurrencyCode)! as! NSLocale
        let numberFromField = (NSString(string: currencyString).doubleValue)/100
        txtValue.text = formatter.stringFromNumber(numberFromField)
    }
    
    func calc() {
//        let tip = Double(txtTip.text!)
       let bill = Double(txtValue.text!)
//        
//        let tipResult = bill! * tip!/100
//        
//        let total = tipResult + bill!
        let tip = Double(15)
        
        let tipResult = bill! * tip/100
        
        let total = (round(tipResult + bill!)*100)/100
        let locale = NSLocale.currentLocale()
        let currencySymbol = locale.objectForKey(NSLocaleCurrencySymbol)!
        //let currencyCode = locale.objectForKey(NSLocaleCurrencyCode)!
        
        //Implement a settings to round or not the value
        lblResult.text = "Total: \(currencySymbol) \(total)"
        
    }
    

}

