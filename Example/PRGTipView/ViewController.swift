//
//  ViewController.swift
//  PRGTipView
//
//  Created by John Spiropoulos on 06/08/2020.
//  Copyright (c) 2020 John Spiropoulos. All rights reserved.
//

import UIKit
import PRGTipView

class ViewController: UIViewController {
    @IBOutlet weak var animInSwitch: UISwitch!
    @IBOutlet weak var animOutSwitch: UISwitch!
    @IBOutlet weak var pulseSwitch: UISwitch!
    
    @IBOutlet weak var rectBtn: UIButton!
    @IBOutlet weak var noFocusBtn: UIButton!
    @IBOutlet weak var circularBtn: UIButton!
    @IBOutlet weak var circBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    
    @IBAction func createConfig(_ sender: UIButton) {
        
        let config = PRGTipViewConfiguration()
        config.animateIn = animInSwitch.isOn
        config.animateOut = animOutSwitch.isOn
        config.pulseMode = pulseSwitch.isOn ? .pulse(repeatCount: Int.max, backgroundColors: [UIColor.white], borderColors: [UIColor.white], lineWidth: 3) : .none
        config.buttonText = "OK"
        config.focusDistance = 20
        config.focusView = sender
        switch sender {
        case rectBtn:
            config.circularFocus = false
            config.focusInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            config.titleText = "Rectangular"
            config.detailText = "This is how you present a tip with a rectangular mask over the focused view. You can add insets as well"
        case noFocusBtn:
            config.focusView = nil
            config.titleText = "No Focus View"
            config.detailText = "You can also not pass a focus view, the tip texts will be centered on the Y axis"
        case circularBtn:
            config.circularFocus = true
            config.titleText = "Circular"
            let detailStr = NSMutableAttributedString(string: "This is how you present a tip with a circular mask over the focused view. You can also use ", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.white])
            let attr = NSMutableAttributedString(string: "Attributed Strings", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.red])
            detailStr.append(attr)
            config.attributedDetailText = detailStr
        case circBtn:
            config.useLargestDimension = false
            config.circularFocus = true
            config.titleText = "Circ"
            config.detailText = "If you have a rectangular view but you need to focus with a circle on it's center, you can set \"useLargestDimension\" to false"
        default: break
        }
        
        PRGTipView.show(fromViewController: self, withConfiguration: config, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        circularBtn.layer.cornerRadius = circularBtn.frame.height / 2
    }
}

