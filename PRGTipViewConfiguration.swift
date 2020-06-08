//
//  PRGTipViewConfiguration.swift
//
//  Created by John Spiropoulos on 8/6/20.
//

import Foundation

public class PRGTipViewConfiguration {
    public var titleText: String?
    public var titleTextFont: UIFont = UIFont.boldSystemFont(ofSize: 25)
    public var titleTextColor: UIColor = .white
    public var attributedTitleText: NSAttributedString?
    
    public var detailText: String?
    public var detailTextFont: UIFont = UIFont.systemFont(ofSize: 20)
    public var detailTextColor: UIColor = .white
    public var attributedDetailText: NSAttributedString?
    
    public var buttonText: String?
    public var buttonTextFont: UIFont = UIFont.boldSystemFont(ofSize: 14)
    public var buttonTextColor: UIColor = .white
    public var attributedButtonText: NSAttributedString?
    
    public var backgroundColor: UIColor = .black
    public var backgroundAlpha: CGFloat = 0.85
    public var tipTextYSpacing: CGFloat = 30
    
    public weak var focusView: UIView?
    public var circularFocus: Bool = false
    public var useLargestDimension: Bool = false
    public var focusInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    public var animateIn: Bool = true
    public var animateOut: Bool = true
    public var pulseMode: PRGTipViewFocusViewPulseMode = .none
    
    public var buttonAction: (()->())?
    public var focusDistance: CGFloat = 0
    public var tipContainerLeading: CGFloat = 20
    public var tipContainerTrailing: CGFloat = 20
    public var animationsDuration: Double = 0.3
}

public enum PRGTipViewFocusViewPulseMode {
    case none, pulse(repeatCount: Int, backgroundColors: [UIColor], borderColors: [UIColor], lineWidth: CGFloat)
}
