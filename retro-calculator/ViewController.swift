//
//  ViewController.swift
//  retro-calculator
//
//  Created by Vincent GROSSIER on 10/02/2016.
//  Copyright © 2016 Kodappy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Substract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var buttonSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var result = ""
    var currentOperation: Operation = .Empty

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }

    @IBAction func onDividedPressed(sender: AnyObject) {
        processOperation(.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(.Multiply)
    }
    
    @IBAction func onSubstractPressed(sender: AnyObject) {
        processOperation(.Substract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        runningNumber = ""
        leftValString = ""
        rightValString = ""
        result = ""
        currentOperation = .Empty
        outputLabel.text = "0"
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                if currentOperation == .Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == .Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == .Substract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == .Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outputLabel.text = result
            }
            
            currentOperation = op
        } else {
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
}

