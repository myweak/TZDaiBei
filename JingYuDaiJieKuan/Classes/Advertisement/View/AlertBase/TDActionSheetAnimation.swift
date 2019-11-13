//
//  TDActionSheetAnimation.swift
//  TDAlertViewController
//
//  Created by LuoJieFeng on 2017/7/18.
//  Copyright © 2017年 LuoJieFeng. All rights reserved.
//

import Foundation
import UIKit

open class TDActionSheetAnimation: TDAlertBaseAnimation {

    override func presentAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let alertViewController = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)) as? TDAlertViewController
        alertViewController?.td_backgroundView.alpha = 0.0
        var y: CGFloat = 0
        if alertViewController?.td_ContainerView != nil {
            y = (alertViewController?.td_ContainerView.frame.size.height)!
        }
        alertViewController?.td_ContainerView.transform = CGAffineTransform(translationX: 0, y: y)
        let containerView = transitionContext.containerView
        containerView.addSubview((alertViewController?.view)!)

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       delay: 0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
                        alertViewController?.td_backgroundView.alpha = 1.0
                        alertViewController?.td_ContainerView.transform = CGAffineTransform(translationX: 0, y: -10) },
                       completion: { (_) in
                        UIView.animate(withDuration: 0.2, animations: {
                            alertViewController?.td_ContainerView.transform = CGAffineTransform.identity
                        }, completion: { (_) in
                            transitionContext.completeTransition(true)
                        }) })
    }

    override func dismissAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let alertViewController = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)) as? TDAlertViewController
        var y: CGFloat = 0
        if alertViewController?.td_ContainerView != nil {
            y = (alertViewController?.td_ContainerView.frame.size.height)!
        }
        UIView.animate(withDuration: 0.25,
                       animations: {
                        alertViewController?.td_backgroundView.alpha = 0.0
                        alertViewController?.td_ContainerView.transform =  CGAffineTransform(translationX: 0, y: y) },
                       completion: { (_) in transitionContext.completeTransition(true) })
    }

}
