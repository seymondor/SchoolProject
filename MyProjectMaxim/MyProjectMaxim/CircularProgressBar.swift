//
//  CircularProgressBar.swift
//  MyProjectMaxim
//
//  Created by 1 on 13.01.2024.
//

import UIKit

class CircularProgressBar: UIView {
    fileprivate var progressLayer =  CAShapeLayer() // !
    fileprivate var trackLayer = CAShapeLayer() // !
    lazy var usedWaterPercentage : Float = Float(ceil((Double(Keys.usedWater)/Double(Keys.water))*100))
    lazy var usedFoodPercentage : Float = Float(ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100))
    
    override init(frame: CGRect){
        super.init(frame: frame)
        createCircularPath()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    var progressColor = UIColor.white {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    var trackColor = UIColor.white {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    fileprivate func createCircularPath(){
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width / 2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.width/2), radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 10.0
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0.5
        layer.addSublayer(progressLayer)
    }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float, from: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = from
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateprogress")
    }
    
//    func changeBarValue(from bar: CircularProgressBar, withKey keyBar: String, percentage percentageLabel: UILabel, amountLabel amountOfSomethingLabel: UILabel, fromValuePercentage: Float, toValuePercentage: Float) {
//        switch keyBar {
//        case "water":
//            bar.setProgressWithAnimation(duration: 1.0, value: toValuePercentage, from: fromValuePercentage)
//            percentageLabel.text = "\(Int(usedWaterPercentage))%"
//            amountOfSomethingLabel.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"
//        case "food":
//            bar.setProgressWithAnimation(duration: 1.0, value: toValuePercentage, from: fromValuePercentage)
//            percentageLabel.text = "\(Int(usedFoodPercentage))%"
//            amountOfSomethingLabel.text = "\(Int(Keys.usedKkal))/\(Int(Keys.kkal))kkal"
//        default:
//            break
//        }
//    }
//        
//    func changeBar(which bar: CircularProgressBar, toBarWithKey keyFutureBar: String, withEmoji emojiSelectedBar: UIImageView, andBackgroundEmoji backgroundOfEmojiSelectedBar: UIView, percentage percentageLabel: UILabel, amount amountOfSomethingLabel: UILabel) {
//        switch keyFutureBar {
//        case "water":
//            Keys.selectedBar = "water"
//            emojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
//            backgroundOfEmojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
//            emojiSelectedBar.image = UIImage(systemName: "drop.fill")
//            bar.trackColor = #colorLiteral(red: 0.6807348041, green: 0.8550895293, blue: 1, alpha: 1)
//            bar.progressColor = #colorLiteral(red: 0.4277995191, green: 0.7138730807, blue: 1, alpha: 1)
//            changeBarValue(from: bar, withKey: "water", percentage: percentageLabel, amountLabel: amountOfSomethingLabel, fromValuePercentage: 0, toValuePercentage: Float(usedWaterPercentage)/100)
//        case "food":
//            Keys.selectedBar = "food"
//            emojiSelectedBar.backgroundColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
//            backgroundOfEmojiSelectedBar.backgroundColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
//            emojiSelectedBar.image = UIImage(systemName: "carrot.fill")
//            bar.trackColor = #colorLiteral(red: 0.6870872528, green: 0.9167618414, blue: 0.7997073189, alpha: 1)
//            bar.progressColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
//            changeBarValue(from: bar, withKey: "food", percentage: percentageLabel, amountLabel: amountOfSomethingLabel, fromValuePercentage: 0, toValuePercentage: Float(usedFoodPercentage)/100)
//        default:
//            break
//        }
//    }
}
