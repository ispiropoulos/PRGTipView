//
//  PRGTipViewConfiguration.swift
//
//  Created by John Spiropoulos on 8/6/20.
//

import Foundation

public class PRGTipViewConfiguration {

    /// The string to be shown as the Tip View title
    public var titleText: String?
    /// The font of the Tip View title
    public var titleTextFont: UIFont = UIFont.boldSystemFont(ofSize: 25)
    /// The color of the Tip View title
    public var titleTextColor: UIColor = .white
    /// The attributed string to be shown as the Tip View title. If set, it overrides "titleText", "titleTextFont" and "titleTextColor" properties
    public var attributedTitleText: NSAttributedString?
    /// The string to be shown as the Tip View detail
    public var detailText: String?
    /// The font of the Tip View detail
    public var detailTextFont: UIFont = UIFont.systemFont(ofSize: 20)
    /// The color of the Tip View detail
    public var detailTextColor: UIColor = .white
    /// The attributed string to be shown as the Tip View detail. If set, it overrides "detailText", "detailTextFont" and "detailTextColor" properties
    public var attributedDetailText: NSAttributedString?
    /// The string to be shown as the Tip View dismissal button title
    public var buttonText: String?
    /// The font of the Tip View dismissal button
    public var buttonTextFont: UIFont = UIFont.boldSystemFont(ofSize: 14)
    /// The color of the Tip View dismissal button
    public var buttonTextColor: UIColor = .white
    /// The attributed string to be shown as the Tip View dismissal title. If set, it overrides "buttonText", "buttonTextFont" and "buttonTextColor" properties
    public var attributedButtonText: NSAttributedString?
    /// The background color of the Tip View
    public var backgroundColor: UIColor = .black
    /// The background alpha of the Tip View
    public var backgroundAlpha: CGFloat = 0.85
    /// The vertical spacing between the Tip View Title, Detail and Button
    public var tipTextYSpacing: CGFloat = 30
    /// The UIView to be focused when the Tip View is presented
    public weak var focusView: UIView?
    /// If a "focusView" is provided, this property controls whether the mask used to focus on the view should be circular. In default "false" state, the mask is rectangular
    public var circularFocus: Bool = false
    /// If "circularFocus" is set to true for a non square "focusView", leaving this property to "true" will use the "focusView"'s largest dimension to calculate the focus mask radius, while setting it to "false" will use the smallest dimension and centre the circular mask on the "focusView".
    public var useLargestDimension: Bool = true
    /// Adds padding to the "focusView" mask. If "circularFocus" is set to "true", then it adds only the .top inset to the radius calculation.
    public var focusInsets: UIEdgeInsets = UIEdgeInsets.zero
    /// Whether the Tip View should be presented animated. Helpful in situations where you want to chain several Tip Views and you do not want to repeat the animation on each and every one of them.
    public var animateIn: Bool = true
    /// Whether the Tip View should be dismissed animated. Helpful in situations where you want to chain several Tip Views and you do not want to repeat the animation on each and every one of them.
    public var animateOut: Bool = true
    /// Whether the "focusView", if provided, should pulse.
    public var pulseMode: PRGTipViewFocusViewPulseMode = .none
    /// The code to be executed after the Tip View is dismissed
    public var buttonAction: (()->())?
    ///The vertical spacing between the "focusView" and the container of the actual Tip Texts (Title, Detail, Button). If the provided "focusView" is in the bottom half of the screen, the tip container is presented above it and this property is the distance from the bottom of the tip container to the top of the "focusView" mask. If the provided "focusView" is in the top half of the screen, the tip container is presented below it and this property is the distance from the top of the tip container to the bottom of the "focusView" mask.
    public var focusDistance: CGFloat = 0
    /// The spacing between the container of the actual Tip Texts (Title, Detail, Button) to it's superView's leading.
    public var tipContainerLeading: CGFloat = 20
    /// The spacing between the container of the actual Tip Texts (Title, Detail, Button) trailing to it's superView's trailing.
    public var tipContainerTrailing: CGFloat = 20
    /// The duration of any animation that takes place in the Tip View (except from the pulsating effect)
    public var animationsDuration: Double = 0.3
    
   public init() {}
}

public enum PRGTipViewFocusViewPulseMode {
    case none, pulse(repeatCount: Int, backgroundColors: [UIColor], borderColors: [UIColor], lineWidth: CGFloat)
}
