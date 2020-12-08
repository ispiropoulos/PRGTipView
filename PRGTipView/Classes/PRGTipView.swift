//
//  PRGTipView.swift
//
//  Created by John Spiropoulos on 8/6/20.
//

import Foundation
import UIKit
import CoreGraphics

public class PRGTipView: UIViewController {
    
    public var configuration: PRGTipViewConfiguration
    public var focusRect: CGRect?
    
    
    private var overlayView: PRGAnimatableMaskedView?
    
    private let containerView: UIStackView = {
        let view = UIStackView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let textLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.contentHorizontalAlignment = .left
        btn.backgroundColor = UIColor(white: 1, alpha: 0)
        btn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    init(configuration: PRGTipViewConfiguration) {
        self.configuration = configuration
        var focusRect: CGRect {
            if let view = configuration.focusView,
                let viewRect = view.superview?.convert(view.frame, to: nil) {
                return viewRect
            }
            return CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 0, height: 0)
        }
       self.overlayView = PRGAnimatableMaskedView(
            frame: UIScreen.main.bounds,
            backgroundColor: configuration.backgroundColor.withAlphaComponent(configuration.backgroundAlpha),
            maskFrame: focusRect,
            inset: configuration.focusInsets,
            isCircular: configuration.circularFocus,
            useLargestDimension: configuration.useLargestDimension,
            pulseMode: configuration.pulseMode,
            animationsDuration: configuration.animationsDuration
        )
        self.focusRect = focusRect
        
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        containerView.spacing = configuration.tipTextYSpacing
        if let overlayView = overlayView {
            view.backgroundColor = .clear
            view.addSubview(overlayView)
        } else {
            view.backgroundColor = configuration.backgroundColor.withAlphaComponent(configuration.backgroundAlpha)
        }
        view.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: configuration.tipContainerLeading).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -configuration.tipContainerTrailing).isActive = true
        
        if configuration.focusView == nil {
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else {
            let centerY = (focusRect?.origin.y ?? 0) + (focusRect?.size.height ?? 0)/2
            
            if centerY > (UIScreen.main.bounds.size.height)/2 {
                let distance = configuration.focusDistance + configuration.focusInsets.top
                let difference = UIScreen.main.bounds.height - (focusRect?.origin.y ?? 0)
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(difference + distance)).isActive = true
            } else {
                let distance = configuration.focusDistance + configuration.focusInsets.bottom
                let difference = (focusRect?.origin.y ?? 0) + (focusRect?.size.height ?? 0)
                containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: difference + distance).isActive = true
            }
        }
        containerView.addArrangedSubview(titleLbl)
        containerView.addArrangedSubview(textLbl)
        containerView.addArrangedSubview(button)
        
        titleLbl.font = configuration.titleTextFont
        titleLbl.textColor = configuration.titleTextColor
        if let attrTitle = configuration.attributedTitleText {
            titleLbl.attributedText = attrTitle
        } else {
            titleLbl.text = configuration.titleText
        }
        
        
        textLbl.font = configuration.detailTextFont
        textLbl.textColor = configuration.detailTextColor
        if let attrDetail = configuration.attributedDetailText {
            textLbl.attributedText = attrDetail
        } else {
            textLbl.text = configuration.detailText
        }
        
        
        button.setTitleColor(configuration.buttonTextColor, for: .normal)
        button.titleLabel?.font = configuration.buttonTextFont
        
        if let attrButton = configuration.attributedButtonText {
            button.setAttributedTitle(attrButton, for: .normal)
        } else {
            button.setTitle(configuration.buttonText, for: .normal)
        }
        
        UIView.animate(withDuration: configuration.animateIn ? configuration.animationsDuration : 0) { [weak self] in
            self?.containerView.alpha = 1
        }
        overlayView?.show(animated: configuration.animateIn)
    }
    
    @objc private func btnTapped(_ sender: UIButton) {
        UIView.animate(withDuration: configuration.animateOut ? configuration.animationsDuration : 0) { [weak self] in
            self?.containerView.alpha = 0
        }
        
        overlayView?.hide(animated: configuration.animateOut) {[weak self] in
            self?.dismiss(animated: false, completion: {
                self?.configuration.buttonAction?()
            })
            
            
        }
     
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("TipView has been deinitialised")
    }
    
    public static func show(fromViewController viewController: UIViewController, withConfiguration configuration: PRGTipViewConfiguration, completion: (()->())?) {
        let tipView = PRGTipView(configuration: configuration)
        viewController.present(tipView, animated: false, completion: completion)
    }
}






