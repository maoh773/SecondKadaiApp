//
//  ViewControllerTransition.swift
//  SecondKadaiApp
//
//  Created by AiTH2 on 2018/12/08.
//  Copyright © 2018 hirohisa.kimura. All rights reserved.
//

import UIKit

class ViewControllerTransition: NSObject , UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return presentedAnimater()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return dismissedAnimater()
    }
    
}

class presentedAnimater : NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        let container = transitionContext.containerView
        container.addSubview(toVC.view)
        
        (fromVC as! ViewController).button.isHidden = true
        
        let animateView = UIView()
        animateView.frame = (fromVC as! ViewController).button.frame
        animateView.backgroundColor = UIColor.init(hex: "e000e0")
        animateView.layer.borderWidth = 1.0
        animateView.layer.borderColor = UIColor.init(hex: "ff00ff").cgColor
        animateView.layer.cornerRadius = 25
        animateView.clipsToBounds = true
        
        container.addSubview(animateView)
        
        let label = UILabel()
        label.frame.origin = CGPoint(x: 0, y: 0)
        label.frame.size = animateView.frame.size
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "OK"
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        animateView.addSubview(label)
        
        let rippleView = UIView()
        rippleView.frame.origin = CGPoint(x: 0, y: -label.frame.width/2 + 25)
        rippleView.frame.size = CGSize(width: label.frame.width, height: label.frame.width)
        rippleView.backgroundColor = UIColor.gray
        rippleView.layer.cornerRadius = label.frame.width/2
        
        animateView.addSubview(rippleView)
        
        rippleView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        rippleView.alpha = 0.8
        
        toVC.view.alpha = 0.0
        toVC.view.layoutIfNeeded()
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext)*3/8,
            delay: 0.0,
            options: [.curveEaseInOut],
            animations: {
                rippleView.transform = .identity
                rippleView.alpha = 0.0
            },
            completion: {_ in
                rippleView.removeFromSuperview()
                label.removeFromSuperview()
                UIView.animate(
                    withDuration: self.transitionDuration(using: transitionContext)*2/8,
                    delay: 0.0,
                    usingSpringWithDamping: 0.7,
                    initialSpringVelocity: 0.5,
                    options: [.curveEaseInOut],
                    animations: {
                        animateView.frame = CGRect(x: animateView.center.x - 25, y: animateView.center.y - 25, width: 50, height: 50)
                    },
                    completion: {_ in
                        UIView.animate(
                            withDuration: self.transitionDuration(using: transitionContext)*3/8,
                            delay: 0.0,
                            options: [.curveEaseInOut],
                            animations: {
                                animateView.transform = CGAffineTransform(scaleX: 50.0, y: 50.0)
                            },
                            completion: {_ in
                                animateView.removeFromSuperview()
                                toVC.view.alpha = 1.0
                                transitionContext.completeTransition(true)
                            }
                        )
                    }
                )
            }
        )
    }
}

class dismissedAnimater : NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        let container = transitionContext.containerView
        
        (toVC as! ViewController).button.isHidden = false
        
        container.subviews.forEach {
            view in
            view.removeFromSuperview()
        }
        container.addSubview(toVC.view)
        container.addSubview(fromVC.view)
        
        container.layoutIfNeeded()
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.frame.origin = CGPoint(x: 0, y: container.frame.maxY + 10)
            },
            completion: {_ in
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        )
        
    }
}
