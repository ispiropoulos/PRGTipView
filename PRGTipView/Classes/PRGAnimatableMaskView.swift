//
//  PRGAnimatableMaskView.swift
//
//  Created by John Spiropoulos on 8/6/20.
//

import UIKit

public class PRGAnimatableMaskedView: UIView, CAAnimationDelegate {
    let kAnimatableMaskedViewDismissalAnimationKey = "MASK_LAYER_DISMISSAL_ANIMATION"
    let kAnimatableMaskedViewPresentationAnimationKey = "MASK_LAYER_PRESENTATION_ANIMATION"
    
    public var pathToEnd: CGPath
    public var pathToStart: CGPath
    public var maskLayer: CAShapeLayer
    public var pulseLayer: CAShapeLayer?
    public var pulseMode: PRGTipViewFocusViewPulseMode?
    public var animationsDuration: Double
    
    private var dismissalCompletion: (()->())?
    init(frame: CGRect, backgroundColor: UIColor, maskFrame: CGRect, inset: UIEdgeInsets, isCircular: Bool, useLargestDimension: Bool, pulseMode: PRGTipViewFocusViewPulseMode, animationsDuration: Double) {
        self.animationsDuration = animationsDuration
        let path = CGMutablePath()
        let endPath = CGMutablePath()
        let largest = useLargestDimension ?
            max(maskFrame.width, maskFrame.height) : min(maskFrame.width, maskFrame.height)
        
        if isCircular {
            let center = CGPoint(x: maskFrame.midX, y: maskFrame.midY)
            [path, endPath].forEach({
                $0.addArc(
                    center: center,
                    radius: largest/2 + inset.top,
                    startAngle: 0.0,
                    endAngle: 2.0 * .pi,
                    clockwise: false
                )
            })
            
        } else {
            let invertInset = UIEdgeInsets(
                top: -inset.top,
                left: -inset.left,
                bottom: -inset.bottom,
                right: -inset.right
            )
            let rect = maskFrame.inset(by: invertInset)
            [path, endPath].forEach({
                $0.addRect(rect)
            })
        }
        let maskCenterPoint = CGPoint(x: maskFrame.midX, y: maskFrame.midY)
        endPath.addArc(
            center: maskCenterPoint,
            radius: AnimatableMaskViewHelpers.maximumCornerDistance(of: frame, from: maskCenterPoint),
            startAngle: 0.0,
            endAngle: 2.0 * .pi,
            clockwise: false
        )
        
        self.pathToEnd = endPath
        
        
        path.addArc(
            center: maskCenterPoint,
            radius: (isCircular ? (largest/2) + inset.top: largest + inset.top + inset.bottom),
            startAngle: 0.0,
            endAngle: 2.0 * .pi,
            clockwise: false
        )
        
        pathToStart = path
        maskLayer = CAShapeLayer()
        
        super.init(frame: frame)
        
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = .evenOdd
        maskLayer.anchorPoint = CGPoint(x: 0, y: 0)
        self.backgroundColor = backgroundColor
        
        layer.mask = maskLayer
        self.pulseMode = pulseMode
        switch pulseMode {
        case .pulse:
            pulseLayer = CAShapeLayer()
            let pulseLayerPath = CGMutablePath()
            let invertInset = UIEdgeInsets(
                top: -inset.top,
                left: -inset.left,
                bottom: -inset.bottom,
                right: -inset.right
            )
            let insetRect = maskFrame.inset(by: invertInset)
            pulseLayer?.frame = insetRect
            if isCircular {
                pulseLayerPath.addArc(center: CGPoint(x: insetRect.midX - insetRect.minX, y: insetRect.midY - insetRect.minY), radius: largest/2 + inset.top, startAngle: 0.0, endAngle: 2.0 * .pi, clockwise: false)
            } else {
                pulseLayerPath.addRect(CGRect(x: 0, y: 0, width: insetRect.width, height: insetRect.height))
            }
            pulseLayer?.path = pulseLayerPath
            if let pulseLayer = pulseLayer {
                layer.addSublayer(pulseLayer)
            }
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(animated: Bool) {
        handlePresentation(animated: animated, dismissal: false)
    }
    
    func hide(animated: Bool, completion:(()->())? = nil) {
        handlePresentation(animated: animated, dismissal: true, dismissalCompletion: completion)
    }
    
    func handlePresentation(animated: Bool, dismissal: Bool = false, dismissalCompletion: (()->())? = nil) {
        self.dismissalCompletion = dismissalCompletion
        let anim = CABasicAnimation(keyPath: "path")
        anim.fromValue = dismissal ? pathToEnd : pathToStart
        anim.toValue = dismissal ? pathToStart : pathToEnd
        anim.fillMode = .forwards
        anim.isRemovedOnCompletion = false
        var duration: Double {
            if dismissal { return animated ? animationsDuration : 0.01}
            return animated ? animationsDuration : 0.01
        }
        anim.duration = duration
        anim.timingFunction = CAMediaTimingFunction(name: .linear)
        anim.delegate = self
        
        if dismissal {
            pulseLayer?.removePulses()
        }
        maskLayer.add(anim, forKey: dismissal ? kAnimatableMaskedViewDismissalAnimationKey : kAnimatableMaskedViewPresentationAnimationKey)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == maskLayer.animation(forKey: kAnimatableMaskedViewDismissalAnimationKey), flag {
            dismissalCompletion?()
        }
        if anim == maskLayer.animation(forKey: kAnimatableMaskedViewPresentationAnimationKey) {
            switch pulseMode {
            case .some(.pulse(let repeatCount, let backgroundColors, let borderColors, let lineWidth)):
                DispatchQueue.main.async { [weak self] in
                    _ = self?.pulseLayer?.addPulse { (pulse) in
                                       pulse.repeatCount = repeatCount
                                       pulse.borderColors = borderColors.map({$0.cgColor})
                                       pulse.backgroundColors = backgroundColors.map({$0.cgColor})
                                       pulse.lineWidth = lineWidth
                                   }
                }
               
            default: break
            }
        }
    }
}

private class AnimatableMaskViewHelpers {
    static func distance(fromPoint: CGPoint, to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - fromPoint.x), 2) + pow((point.y - fromPoint.y), 2))
    }
    
    static func maximumCornerDistance(of rect: CGRect, from point: CGPoint) -> CGFloat {
        let topLeft = rect.origin
        let fromTopLeft = distance(fromPoint: topLeft, to: point)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let fromTopRight = distance(fromPoint: topRight, to: point)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let fromBottomLeft = distance(fromPoint: bottomLeft, to: point)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let fromBottomRight = distance(fromPoint: bottomRight, to: point)
        return max(fromBottomLeft, fromBottomRight, fromTopLeft, fromTopRight)
    }
}
