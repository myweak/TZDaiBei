//
//  TDAlertCommonView.swift
//  TDAlertViewController
//
//  Created by LuoJieFeng on 2017/7/18.
//  Copyright © 2017年 LuoJieFeng. All rights reserved.
//

import UIKit

@objc open class TDAlertCommonView: UIView {

    public var backgroundAction: (() -> Void)?
    public var animationStyle: TDAlertAnimationStyle
    public var alertStyle: TDAlertStyle
    public weak var alertViewController: TDAlertViewController?

    public init(animationStyle: TDAlertAnimationStyle, alertStyle: TDAlertStyle) {
        self.animationStyle = animationStyle
        self.alertStyle     = alertStyle
        super.init(frame: CGRect.zero)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc open func showAlertView(inViewController: UIViewController, leftOrRightMargin: CGFloat) {
        let alertViewController = TDAlertViewController(animationStyle: self.animationStyle, alertStyle: self.alertStyle, containerView: self, margin: leftOrRightMargin)
        self.alertViewController = alertViewController
        weak var weakSelf = self
        self.alertViewController?.clickBackgroundAction = {
            if weakSelf?.backgroundAction != nil {
                weakSelf?.backgroundAction!()
            }
        }
        self.alertViewController?.showAlertViewController(inViewController: inViewController, complete: nil)
    }

    open func hiddenAlertView() {
        self.alertViewController?.hiddenAlertViewController(hiddenComplete: nil)
    }

    open func hiddenAlertView(complete: @escaping () -> Void) {
        self.alertViewController?.hiddenAlertViewController(hiddenComplete: complete)
    }
}
