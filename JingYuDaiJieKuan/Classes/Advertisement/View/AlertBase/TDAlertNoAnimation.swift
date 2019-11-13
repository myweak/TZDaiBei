//
//  TDAlertNoAnimation.swift
//  TDAlertViewController
//
//  Created by LuoJieFeng on 2017/7/18.
//  Copyright © 2017年 LuoJieFeng. All rights reserved.
//

import Foundation
import UIKit

open class TDAlertNoAnimation: TDAlertBaseAnimation {

    override func presentAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let alertViewController = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)) as? TDAlertViewController
        alertViewController?.td_backgroundView.alpha = 1.0
        alertViewController?.td_ContainerView.transform = CGAffineTransform.identity
        let containerView = transitionContext.containerView
        containerView.addSubview((alertViewController?.view)!)
        transitionContext.completeTransition(true)
    }

    override func dismissAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let alertViewController = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)) as? TDAlertViewController
        alertViewController?.td_backgroundView.alpha = 0.0
        var y: CGFloat = 0
        if alertViewController?.td_ContainerView != nil {
             y = (alertViewController?.td_ContainerView.frame.size.height)!
        }
        alertViewController?.td_ContainerView.transform = CGAffineTransform().translatedBy(x: 0, y: y)
        transitionContext.completeTransition(true)
    }

}
