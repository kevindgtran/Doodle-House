//
//  SettingsVC.swift
//  Doodler
//
//  Created by Kevin Tran on 6/10/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol SettingsVCDelegate: class {  //protocal to send data back to ViewController
    func settingsViewControllerDidFinish(_ settingsVC: SettingsVC)
}

class SettingsVC: UIViewController {
    
    //MARK: - Variables
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushSize = CGFloat()
    var opacityValue: CGFloat = 1.0
    
    //MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brushSizeLabel: UILabel!
    @IBOutlet weak var opacityLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var brushSizeSlider: UISlider!
    
    var delegate: SettingsVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawPreview(red: red, green: green, blue: blue)  //update RGB from ViewController
        setSliderValues()
    }//end of viewDidLoad
    
    //MARK: - Actions
    @IBAction func dismiss(_ sender: Any) {
        if delegate != nil {
            delegate?.settingsViewControllerDidFinish(self)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func brushSizeChanged(_ sender: Any) {
        let slider = sender as! UISlider
        brushSize = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
    }
    
    @IBAction func opacityChanged(_ sender: Any) {
        let slider = sender as! UISlider
        opacityValue = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
    }
    
    @IBAction func redSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider  //reference from slider
        
        red = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        redLabel.text = "\(Int(slider.value * 255))"
    }//end of redSliderChanged action
    
    @IBAction func greenSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider
        
        green = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        greenLabel.text = "\(Int(slider.value * 255))"
    }//end of greenSliderChanged action
    
    @IBAction func blueSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider
        
        blue = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        blueLabel.text = "\(Int(slider.value * 255))"
    }//end of blueSliderChanged action
    
    //MARK: - Functions
    func setSliderValues() {
        
        brushSizeSlider.value = Float(brushSize)
        
        redSlider.value = Float(red)  //slider values
        redLabel.text = "\(Int(redSlider.value * 255))"
        
        greenSlider.value = Float(green)
        greenLabel.text = "\(Int(greenSlider.value * 255))"
        
        blueSlider.value = Float(blue)
        blueLabel.text = "\(Int(blueSlider.value * 255))"
    }
    
    func drawPreview(red: CGFloat, green: CGFloat, blue: CGFloat) {
        imageView.layer.cornerRadius = 0
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: opacityValue).cgColor)  //brush size
        context?.setLineWidth(brushSize)
        context?.setLineCap(CGLineCap.round)
        
        context?.move(to: CGPoint(x:50, y:50))  //center image
        context?.addLine(to: CGPoint(x:50, y:50))
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }//end of drawPreview function
    
    
}//end of SettingsVC

