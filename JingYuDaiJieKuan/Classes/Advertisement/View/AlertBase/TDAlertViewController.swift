//
//  TDAlertViewController.swift
//  TDAlertViewController
//
//  Created by LuoJieFeng on 2017/7/18.
//  Copyright © 2017nian LuoJieFeng. All rights reserved.
//

import UIKit
import SnapKit

public enum TDAlertStyle: Int {

    /// 底部弹出
    case TDAlertStyleActionSheet = 0

    /// 中心点对齐
    case TDAlertStyleAlert       = 1
}

public enum TDAlertAnimationStyle: Int {

    /// 渐现+弹出
    case TDAlertFadePop = 0

    /// 系统action view动画效果
    case TDActionSheetPop = 1

    /// 没有动画
    case TDAlertNoAnimationPop = 2
}

open class TDAlertViewController: UIViewController {

    var td_ContainerView: UIView
    var td_ViewStyle: TDAlertStyle
    var td_AnimationStyle: TDAlertAnimationStyle
    var td_Magin: CGFloat
    var td_showTime: TimeInterval = 0
    var td_dismissTime: TimeInterval = 0
    var isCusAnimationTime: Bool = false
    
    public var clickBackgroundAction: (() -> Void)?

    ///可以实现以下blcok,对自己的视图，进行更精细的封装
    public var viewWillApper: (() -> Void)?
    public var viewDidApper: (() -> Void)?
    public var viewWillDisApper: (() -> Void)?
    public var viewDidDisApper: (() -> Void)?

    lazy var td_backgroundView: UIControl = {
        var control = UIControl()
        control.isUserInteractionEnabled = true
        control.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        control.addTarget(self, action: #selector(backgroundViewAction), for: .touchUpInside)
        return control
    }()

    public init(animationStyle: TDAlertAnimationStyle, alertStyle: TDAlertStyle, containerView: UIView, margin: CGFloat) {
        self.td_ViewStyle = alertStyle
        self.td_AnimationStyle = animationStyle
        self.td_ContainerView = containerView
        self.td_Magin = margin
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = false
        self.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.custom
        self.transitioningDelegate = self
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(td_backgroundView)
        self.view.addSubview(td_ContainerView)

        td_backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets.zero)
        }
        td_ContainerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(td_Magin)
            make.right.equalTo(self.view).offset(-td_Magin)
        }
        if self.td_ViewStyle == .TDAlertStyleActionSheet {
            td_ContainerView.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.view)
            }
        } else {
            td_ContainerView.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.view)
            }
        }
        self.view.layoutIfNeeded()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.viewWillApper != nil {
            self.viewWillApper!()
        }
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.viewDidApper != nil {
            self.viewDidApper!()
        }
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.viewWillDisApper != nil {
            self.viewWillDisApper!()
        }
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.viewDidDisApper != nil {
            self.viewDidDisApper!()
        }
    }

    func setAlertAnimation(showTime: TimeInterval, dismisssTime: TimeInterval) {
        self.td_showTime = showTime
        self.td_dismissTime = dismisssTime
        self.isCusAnimationTime = true
    }

    @objc func backgroundViewAction() {
        if clickBackgroundAction != nil {
            clickBackgroundAction!()
        }
    }

    open func showAlertViewController(inViewController: UIViewController?, complete: (() -> Void)?) {
        if inViewController != nil {
            if (inViewController?.presentedViewController) != nil {
                inViewController?.presentedViewController?.present(self, animated: true, completion: complete)
            } else {
                inViewController?.present(self, animated: true, completion: complete)
            }
        } else {
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController
            rootViewController?.present(self, animated: true, completion: complete)
        }
    }

    open func hiddenAlertViewController(hiddenComplete: (() -> Void)?) {
       self.dismiss(animated: true, completion: hiddenComplete)
    }
}

extension TDAlertViewController: UIViewControllerTransitioningDelegate {

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch self.td_AnimationStyle {
        case .TDAlertFadePop:
            return TDAlertFadePopAnimation(isPresenting: true)
        case .TDActionSheetPop:
            return TDActionSheetAnimation(isPresenting: true)
        case .TDAlertNoAnimationPop:
            return TDAlertNoAnimation(isPresenting: true)
        }
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch self.td_AnimationStyle {
        case .TDAlertFadePop:
            if self.isCusAnimationTime {
              return TDAlertFadePopAnimation(isPresenting: false, showAnimationTime: td_showTime, dismissAnimationTime: td_dismissTime)
            }
            return TDAlertFadePopAnimation(isPresenting: false)
        case .TDActionSheetPop:
            if self.isCusAnimationTime {
                return TDActionSheetAnimation(isPresenting: false, showAnimationTime: td_showTime, dismissAnimationTime: td_dismissTime)
            }
            return TDActionSheetAnimation(isPresenting: false)
        case .TDAlertNoAnimationPop:
            if self.isCusAnimationTime {
                return TDAlertNoAnimation(isPresenting: false, showAnimationTime: td_showTime, dismissAnimationTime: td_dismissTime)
            }
            return TDAlertNoAnimation(isPresenting: false)
        }
    }

}
