//
//  TDAlertFadePopAnimation.swift
//  TDAlertViewController
//
//  Created by LuoJieFeng on 2017/7/18.
//  Copyright © 2017年 LuoJieFeng. All rights reserved.
//

import Foundation
import UIKit

open class TDAlertFadePopAnimation: TDAlertBaseAnimation {

    override func presentAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {

        let alertViewController = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)) as? TDAlertViewController
        alertViewController?.td_backgroundView.alpha = 0.0
        alertViewController?.td_backgroundView.alpha = 0.0
        alertViewController?.td_ContainerView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        let containerView = transitionContext.containerView
        containerView.addSubview((alertViewController?.view)!)
        UIView.animate(withDuration: 0.1,
                       animations: {
                        alertViewController?.td_backgroundView.alpha = 1.0
                        alertViewController?.td_ContainerView.alpha = 1.0
                        alertViewController?.td_ContainerView.transform =  CGAffineTransform(scaleX: 1.05, y: 1.05)},
                       completion: { (_) in
                        UIView.animate(withDuration: 0.15, animations: {
                            alertViewController?.td_ContainerView.transform = CGAffineTransform.identity
                        }, completion: { (_) in
                            transitionContext.completeTransition(true)
                        })})
    }

    override func dismissAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let alertViewController = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)) as? TDAlertViewController
        UIView.animate(withDuration: 0.25,
                       animations: {
                        // 20180615 处理弹出2个或多个框后，点击四周时，会引起第二个或后面的弹窗无法消失
                        // 故先注释掉
//                        alertViewController?.td_backgroundView.alpha = 0.0
//                        alertViewController?.td_ContainerView.alpha = 0.0
                        alertViewController?.td_ContainerView.transform =  CGAffineTransform(scaleX: 0.9, y: 0.9)},
                       completion: { (_) in
                        transitionContext.completeTransition(true)})
    }
}
