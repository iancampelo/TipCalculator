//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Ian Campelo on 9/29/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var roundSwitch: UISwitch!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    
    @IBOutlet weak var minSlider: UISlider!
    @IBOutlet weak var defaultSlider: UISlider!
    @IBOutlet weak var maxSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minSlider.addTarget(self, action: #selector(SettingsViewController.sliderValueChanged(_:)), forControlEvents: UIControlEvents.AllEvents)
        
        defaultSlider.addTarget(self, action: #selector(SettingsViewController.sliderValueChanged(_:)), forControlEvents: UIControlEvents.AllEvents)
        
        maxSlider.addTarget(self, action: #selector(SettingsViewController.sliderValueChanged(_:)), forControlEvents: UIControlEvents.AllEvents)
        
        //check if exists value saved on memory and update items on the view
        let defaults = NSUserDefaults.standardUserDefaults()
        let round = defaults.boolForKey("round")
        let minV = defaults.floatForKey("minValue")
        let defaultV = defaults.floatForKey("defaultValue")
        let maxV = defaults.floatForKey("maxValue")
        
        roundSwitch.on = round;
        if(minV > 0){
            minSlider.value = minV
        }
        if(defaultV > 0){
            defaultSlider.value = defaultV
        }
        if(maxV > 0){
            maxSlider.value = maxV
        }
        setLabelValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLabelValues(){
        let valueMin = Int(minSlider.value)
        let valueDefault = Int(defaultSlider.value)
        let valueMax = Int(maxSlider.value)
        
        minLabel.text = "Min tip: \(valueMin)%"
        defaultLabel.text = "Default tip: \(valueDefault)%"
        maxLabel.text = "Max tip: \(valueMax)%"
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateDefaultTip()
        super.viewWillDisappear(animated)
    }
    
    func updateDefaultTip() {
        // Save the default tip percentage
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setBool(roundSwitch.on, forKey: "round")
        defaults.setFloat(minSlider.value, forKey: "minValue")
        defaults.setFloat(defaultSlider.value, forKey: "defaultValue")
        defaults.setFloat(maxSlider.value, forKey: "maxValue")
        defaults.synchronize()
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        setLabelValues()
        
        let valueMin = Int(minSlider.value)
        let valueDefault = Int(defaultSlider.value)
        let valueMax = Int(maxSlider.value)
        
        if(valueMin >= valueDefault){
            defaultSlider.value = Float(valueMin+1)
            defaultLabel.text = "Default tip: \(defaultSlider.value)%"
        }
        if(valueDefault >= valueMax){
            maxSlider.value = Float(valueDefault+1)
            maxLabel.text = "Max tip: \(maxSlider.value)%"
        }
        
        if(valueMax <= valueDefault){
            defaultSlider.value = Float(valueDefault-1)
            defaultLabel.text = "Default tip: \(defaultSlider.value)%"
        }
        
        if(valueDefault <= valueMin){
            minSlider.value = Float(valueMin-1)
            minLabel.text = "Min tip: \(minSlider.value)%"
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
