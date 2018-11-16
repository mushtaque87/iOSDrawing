//
//  ScoresTableViewCell.swift
//  Drawing
//
//  Created by Mushtaque Ahmed on 11/14/18.
//  Copyright © 2018 Mushtaque Ahmed. All rights reserved.
//

import UIKit

@IBDesignable class ScoresTableViewCell: UITableViewCell {

    var barWidth : CGFloat?
    var score : Int?
    var scoreBar : CAShapeLayer?
    var backGroundBar : CAShapeLayer?
    let smily = UIImageView(frame: CGRect(x:0 , y:0  , width:25 , height: 25))
//    {
//        didSet{
//            drawScoreBars(for: score!)
//        }
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.contentView.backgroundColor = UIColor.black
       
//        if let score = self.score {
//        drawScoreBars(for: score)
//        }
       // self.contentView.backgroundColor = UIColor.red
        
        
        let infoImage = UIImage(named: "icons8-play")
        let imgWidth = infoImage?.size.width
        let imgHeight = infoImage?.size.height
        let playButton:UIButton = UIButton(frame: CGRect(x: 20.0,y: self.contentView.frame.height/2  - (imgHeight!/2) ,width: imgWidth!, height: imgHeight!))
        playButton.setBackgroundImage(infoImage, for: .normal)
        self.contentView.addSubview(playButton)
        self.contentView.addSubview(smily)
        
        
        //playButton.addTarget(self, action:  #selector(), for: .touchUpInside)
        
    }
    
//    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        drawBackgroundLine()
//        drawScoreBars(for: <#T##Float#>)
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutIfNeeded() {
        
    }
    
    override func layoutSubviews() {
       
    }
    func drawBackgroundLine() {
        backGroundBar?.removeFromSuperlayer()
        if (backGroundBar == nil) {
            backGroundBar = CAShapeLayer()
        }
        let linePath = UIBezierPath()
        //linePath.move(to: CGPoint(x: (phoneme.startLabel?.frame.origin.x)!, y: (phoneme.startLabel?.frame.origin.y)!))
        linePath.move(to: CGPoint(x: 20 , y: self.contentView.frame.height/2))
        linePath.addLine(to: CGPoint(x: barWidth! , y: self.contentView.frame.height/2 ))
        backGroundBar?.path = linePath.cgPath
        backGroundBar?.strokeColor = UIColor.lightGray.cgColor
        backGroundBar?.lineWidth = 25
        backGroundBar?.lineCap = kCALineCapRound
        //self.contentView.layer.addSublayer(line)
        self.contentView.layer.insertSublayer(backGroundBar!, at: 0)
    }
    
    func drawScoreBars(for score:Int) {
        scoreBar?.removeFromSuperlayer()
        if (scoreBar == nil) {
         scoreBar = CAShapeLayer()
        }
        let linePath = UIBezierPath()
        //linePath.move(to: CGPoint(x: (phoneme.startLabel?.frame.origin.x)!, y: (phoneme.startLabel?.frame.origin.y)!))
        linePath.move(to: CGPoint(x: 20 , y: self.contentView.frame.height/2))
        let toX = CGFloat(score) * barunitPerScoreUnit(for: barWidth!)
        linePath.addLine(to: CGPoint(x: (score == 0 ? 20.0 + toX : toX) , y: self.contentView.frame.height/2 ))
        
        print("X: \(toX)")
        scoreBar?.path = linePath.cgPath
        scoreBar?.strokeColor = selecColorForBar(for: score).cgColor
        scoreBar?.lineWidth = 25
        scoreBar?.lineCap = kCALineCapRound
        //self.contentView.layer.addSublayer(line)
        self.contentView.layer.insertSublayer(scoreBar!, at: 1)
    }
    
    func getBarWidth() -> CGFloat {
        print("Bar Width \(self.contentView.bounds.width)")
       return self.contentView.bounds.width - 40.0
    }
    
    func barunitPerScoreUnit(for bar:CGFloat) -> CGFloat {
        print("Bar per unit \(bar/100.0)")
        return bar/100.0
    }
    
    func placeSmily(for score:Int) {
        let toX = CGFloat(score) * barunitPerScoreUnit(for: barWidth!)
        smily.frame = CGRect(x:toX - 22.0 , y:self.contentView.frame.height/2  - (25/2)  , width:25 , height: 25)
        switch score {
        case 0...25:
            smily.image = UIImage(named: "icons8-bored")
            break
        case 26...80:
            smily.image = UIImage(named: "icons8-blushing")
            break
        default:
            smily.image = UIImage(named: "icons8-lol")
            break
        }
       
    }
    
    func selecColorForBar(for score:Int) -> UIColor {
        switch score {
        case 0...25:
            return UIColor.red
        case 26...80:
            return UIColor.orange
        default:
           return UIColor.green
        }
    }
//    override func draw(_ rect: CGRect) {
//        print("drawRect : \(score)")
//        drawScoreBars(for: score!)
//    }
    
}
