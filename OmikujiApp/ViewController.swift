//
//  ViewController.swift
//  OmikujiApp
//
//  Created by Harada Yuji on 2018/08/11.
//  Copyright © 2018年 Harada Yuji. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var stickVoew: UIView!
    @IBOutlet weak var stickLabel: UILabel!
    @IBOutlet weak var stickHeight: NSLayoutConstraint!
    @IBOutlet weak var stickBottomMargin: NSLayoutConstraint!
    
    let resultTexts: [String] = [
    "大吉",
    "中吉",
    "小吉",
    "吉",
    "末吉",
    "凶",
    "大凶",
    "吉凶未分",
    "始凶未分"
        
    ]
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    func setupSound() {
        if let sound = Bundle.main.path(forResource:"振る音", ofType: ".mp3"){
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            audioPlayer.prepareToPlay()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupSound()
        overView.alpha = 0
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?){
        if motion != UIEventSubtype.motionShake || overView.isHidden == false{
            return
        }
            audioPlayer.play()
        
        
            
            let resultNum = Int( arc4random_uniform(UInt32(resultTexts.count)))
            stickLabel.text = resultTexts[resultNum]
            stickBottomMargin.constant = stickHeight.constant * -1
            
            UIView.animate(withDuration: 1, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
                self.bigLabel.text = self.stickLabel.text
                self.overView.isHidden = false
                
                UIView.animate(withDuration: 2.0, animations: {
                    self.overView.alpha = 1
                })
            })
        
            
        
            
        }
    @IBOutlet weak var overView: UIView!
    
  
    @IBOutlet weak var bigLabel: UILabel!
    @IBAction func tapRetryButton(_ sender: Any) {
        overView.isHidden = true
        overView.alpha = 0
        stickBottomMargin.constant = 0
    }
    
    
}

    



