//
//  ViewController.swift
//  Drawing
//
//  Created by Mushtaque Ahmed on 10/10/18.
//  Copyright © 2018 Mushtaque Ahmed. All rights reserved.
//

import UIKit

struct PhonemePoints {
    var phoneme : String?
    var position : Int?
    var ismatched : Bool?
    var startLabel : UILabel?
    var endLabel : UILabel?
}

class ViewController: UIViewController {
    let alignedOriginalPhoneme = ["T","AY","P"]
    //let alignedOriginalPhoneme = ["HH","_","_","AH","L","OW"]
    //let originalPhoneme = ["",""]
    
    let alignedPredictedPhoenems = ["_","AY","_"]
   // let alignedPredictedPhoenems = ["HH","EH","T","AH","L","D"]
    //let predictedPhonemes = ["",""]
    
    var phonemeDetailsArray = Array<PhonemePoints>()
    @IBOutlet var scrollView : UIScrollView!
    
    //var orignialPhonemeLabelArray = Array<UILabel>()
    //var pred
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareOriginalPhonemeDetailArray()
        drawPlaceholderLines()
        drawOriginalPhonemeLables()
        drawAlignedPredictedPhonemeLables()
        connectLines()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    func drawPlaceholderLines() {
        for count in 1...alignedOriginalPhoneme.count {
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(3.0)
        context!.setStrokeColor(UIColor.purple.cgColor)
        
        //make and invisible path first then we fill it in
        context!.move(to: CGPoint(x: 50, y: 80 * count))
        context!.addLine(to: CGPoint(x: 250, y:320))
        context!.strokePath()
        }
    }
 */
    func prepareOriginalPhonemeDetailArray() {
        for (count,char) in alignedOriginalPhoneme.enumerated() {
            if (char != "_") {
                
                let phonemepoints = PhonemePoints(phoneme: char, position: count, ismatched: (char == alignedPredictedPhoenems[count] ? true:false) , startLabel: nil , endLabel: nil)
             phonemeDetailsArray.append(phonemepoints)
            } else {
                
            }
        }
    }
    
    func drawOriginalPhonemeLables() {
        for (count,phoneme) in phonemeDetailsArray.enumerated() {
        let label = UILabel(frame: CGRect(x: 10, y: 70 * count + 5, width: 60, height: 60))
        //label.center = CGPointMake(160, 284)
        label.textAlignment = .center
        label.text = phoneme.phoneme
        label.layer.borderColor = UIColor(red: 60.0/255.0, green: 179.0/255.0, blue: 113.0/255.0, alpha: 1).cgColor
            label.layer.borderWidth =  5
            label.layer.cornerRadius = label.frame.size.height / 2
        scrollView.addSubview(label)
        let phonemepoints = PhonemePoints(phoneme: phoneme.phoneme, position: phoneme.position, ismatched: phoneme.ismatched, startLabel: label , endLabel: nil)
           // phonemeDetailsArray.remove(at: count)
          //  phonemeDetailsArray.insert(phonemepoints, at: count)
            phonemeDetailsArray[count] = phonemepoints
        }
    }
    
    
    func drawAlignedPredictedPhonemeLables() {
        for (count,phoneme) in alignedPredictedPhoenems.enumerated() {
            let label = UILabel(frame: CGRect(x: Int(self.view.frame.size.width) - 100, y: 70 * count + 5, width: 60, height: 60))
            //label.center = CGPointMake(160, 284)
            label.textAlignment = .center
            label.text = phoneme
            label.layer.borderColor = UIColor.red.cgColor
            label.layer.borderWidth =  5
            label.layer.cornerRadius = label.frame.size.height / 2
            updateOriginalPhonemeArray(for: count, with: label)
            scrollView.addSubview(label)
        }
    }
    
    func updateOriginalPhonemeArray(for position:Int , with label:UILabel){
        for (count,phoneme) in phonemeDetailsArray.enumerated() {
            if(phoneme.position == position && phoneme.phoneme == label.text){
                let phonemepoints = PhonemePoints(phoneme: phoneme.phoneme, position: phoneme.position, ismatched: phoneme.ismatched, startLabel: phoneme.startLabel, endLabel: label)
               // phonemeDetailsArray.remove(at: count)
           // phonemeDetailsArray.insert(phonemepoints, at: count)
                label.layer.borderColor = UIColor(red: 60.0/255.0, green: 179.0/255.0, blue: 113.0/255.0, alpha: 1).cgColor
                 phonemeDetailsArray[count] = phonemepoints
            }
        }
    }
    
    func drawPlaceholderLines() {
        for count in 1...alignedOriginalPhoneme.count {
            let line = CAShapeLayer()
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: 0, y: 70 * count))
            linePath.addLine(to: CGPoint(x: Int(self.view.frame.size.width) , y: 70 * count))
            line.path = linePath.cgPath
            line.strokeColor = UIColor.lightGray.cgColor
            line.lineWidth = 1
            line.lineJoin = kCALineCapSquare
            scrollView.layer.addSublayer(line)
        }
}
    
    func connectLines() {
         for (count,phoneme) in phonemeDetailsArray.enumerated() {
            if(phoneme.ismatched == true) {
            let line = CAShapeLayer()
            let linePath = UIBezierPath()
            //linePath.move(to: CGPoint(x: (phoneme.startLabel?.frame.origin.x)!, y: (phoneme.startLabel?.frame.origin.y)!))
            linePath.move(to: CGPoint(x: (phoneme.startLabel?.frame.origin.x)! + (phoneme.startLabel?.frame.size.width)! - 2 , y: ((phoneme.startLabel?.frame.origin.y)! + (phoneme.startLabel?.frame.size.height)!/2) ))
            linePath.addLine(to: CGPoint(x: (phoneme.endLabel?.frame.origin.x)! + 2 , y:((phoneme.endLabel?.frame.origin.y)! + (phoneme.endLabel?.frame.size.height)!/2) ))
            print("X: \(phoneme.startLabel?.frame.origin.x)")
            print("Y: \(phoneme.startLabel?.frame.origin.y)")
            line.path = linePath.cgPath
            line.strokeColor = UIColor(red: 60.0/255.0, green: 179.0/255.0, blue: 113.0/255.0, alpha: 1).cgColor
//            if(count == 0) {
//            line.strokeColor = UIColor.green.cgColor
//            } else if(count == 1) {
//                line.strokeColor = UIColor.green.cgColor
//            } else {
//                line.strokeColor = UIColor.green.cgColor
//            }
            line.lineWidth = 5
            line.lineJoin = kCALineCapButt
            scrollView.layer.addSublayer(line)
            }
        }
    }
    
    func lineStartPoint(for label:UILabel) -> CGFloat {
        let labelEndPoint = label.frame.origin.x + label.frame.size.width
        
        return (labelEndPoint + label.frame.size.height)/2
    }
    
    @IBAction func showUI1(){
        let ui1Screen = ScoreBarsTableViewController(nibName: "ScoreBarsTableViewController", bundle: nil, for: [20,40,80,100,20,40,80,100,70,100,10,70,100,10,0,50,20,40,80,100,20,40,80,100,70,100,10,70,100,10,0,50])
        present(ui1Screen, animated: true, completion: nil)
    }
    /*
    func lineEndPoint(to label:UILabel) -> CGFloat {
        
    }*/
}

