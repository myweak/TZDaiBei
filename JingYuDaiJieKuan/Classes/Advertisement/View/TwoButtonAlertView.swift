//
//  TDCustomAlertView.swift
//  XunHuiFinance
//
//  Created by Dason on 2019/9/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

import UIKit
import SnapKit

let TitleLabelTopOffset: CGFloat = 30
let titleLabelLeftAndRightOffset: CGFloat = 40
let detailLabelLeftAndRightOffset: CGFloat = 30
let TitleLabelHeight: CGFloat = 18
let DetailLabelTopOffset: CGFloat = 20
let horizonalLineTopOffset: CGFloat = 30
let buttonHeight: CGFloat = 51

class TwoButtonAlertView: TDAlertCommonView {

    public var isTwoButton: Bool? = true
    @objc public var leftButtonBlock: (() -> Void)?
    @objc public var rightButtonBlock: (() -> Void)?
    public var detailLabelTopConstraint: Constraint?
    public var titleLabelHeightConstraint: Constraint?
    var titleTextObserver: NSKeyValueObservation?
    var titleAttributeTextObserver: NSKeyValueObservation?
    var detailTextObserver: NSKeyValueObservation?
    var detailAttributeTextObserver: NSKeyValueObservation?

    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.init(valueRGB: 0x333333)
        label.textAlignment = .center
        return label
    }()

    public lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(valueRGB: 0x333333)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    public lazy var horizonalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(valueRGB: 0xe5e5e5)
        return view
    }()

    public lazy var verticalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(valueRGB: 0xe5e5e5)
        return view
    }()

    @objc public lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.init(valueRGB: 0x999999), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitle("取消", for: .normal)
        button.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        return button
    }()

    @objc public lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.init(valueRGB: 0xb17e47), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitle("确定", for: .normal)
        button.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        return button
    }()

    @objc init(title: String = "",
         detailTitle: String = "",
         isTwoButton: Bool = true,
         leftAction: (() -> Void)? = nil,
         rightAction: (() -> Void)? = nil) {
        super.init(animationStyle: .TDAlertFadePop, alertStyle: .TDAlertStyleAlert)
        self.isTwoButton = isTwoButton
        self.leftButtonBlock = leftAction
        self.rightButtonBlock = rightAction

        commonInit()
        observeToUpdateConstraint()

        self.titleLabel.text = title
        self.detailLabel.text = detailTitle
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("----\(self.classForCoder) is dealloc ----")
    }

    func commonInit() {
        self.backgroundColor = UIColor.white
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        self.addSubview(horizonalLineView)
        self.addSubview(rightButton)

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(TitleLabelTopOffset)
            make.left.equalTo(self).offset(titleLabelLeftAndRightOffset)
            make.right.equalTo(self).offset(-titleLabelLeftAndRightOffset)
            self.titleLabelHeightConstraint = make.height.equalTo(TitleLabelHeight).constraint
        }

        detailLabel.snp.makeConstraints { (make) in
            self.detailLabelTopConstraint = make.top.equalTo(titleLabel.snp.bottom).offset(DetailLabelTopOffset).constraint
            make.left.equalTo(self).offset(detailLabelLeftAndRightOffset)
            make.right.equalTo(self).offset(-detailLabelLeftAndRightOffset)
            make.bottom.equalTo(horizonalLineView).offset(-horizonalLineTopOffset)
        }

        horizonalLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalTo(rightButton.snp.top)
        }

        if isTwoButton! {
            self.addSubview(verticalLineView)
            verticalLineView.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize(width: 0.5, height: buttonHeight-1))
                make.top.equalTo(horizonalLineView.snp.bottom)
                make.centerX.equalToSuperview()
            }
            self.addSubview(leftButton)
            leftButton.snp.makeConstraints({ (make) in
                make.top.equalTo(horizonalLineView.snp.bottom)
                make.left.equalToSuperview()
                make.right.equalTo(verticalLineView.snp.left)
                make.height.equalTo(buttonHeight-1)
            })

            rightButton.snp.makeConstraints({ (make) in
                make.top.equalTo(horizonalLineView.snp.bottom)
                make.right.equalToSuperview()
                make.left.equalTo(verticalLineView.snp.right)
                make.height.equalTo(buttonHeight-1)
                make.bottom.equalToSuperview()
            })
        } else {
            rightButton.snp.makeConstraints({ (make) in
                make.top.equalTo(horizonalLineView.snp.bottom)
                make.right.left.equalToSuperview()
                make.height.equalTo(buttonHeight-1)
                make.bottom.equalToSuperview()
            })
        }
    }

    func observeToUpdateConstraint() {
        titleTextObserver = titleLabel.observe(\UILabel.text) { [weak self] (label, _) in
            let text = label.text
            guard text != nil else { return }
            if !(text?.isEmpty)! {
                self?.titleLabelHeightConstraint?.update(offset: TitleLabelHeight)
            } else {
                self?.titleLabelHeightConstraint?.update(offset: 0)
            }
        }

        titleAttributeTextObserver = titleLabel.observe(\UILabel.attributedText) {[weak self] (label, _) in
            let text = label.text
            guard text != nil else { return }
            if !(text?.isEmpty)! {
                self?.titleLabelHeightConstraint?.update(offset: TitleLabelHeight)
            } else {
                self?.titleLabelHeightConstraint?.update(offset: 0)
            }
        }

        detailTextObserver = detailLabel.observe(\UILabel.text) { [weak self] (label, _) in
            let text = label.text
            guard text != nil else { return }
            if (text?.isEmpty)! {
                self?.detailLabelTopConstraint?.update(offset: 0)
            } else {
                guard self?.titleLabel.text != nil else {
                    self?.detailLabelTopConstraint?.update(offset: 0)
                    return
                }
                if (self?.titleLabel.text?.isEmpty) == true {
                    self?.detailLabelTopConstraint?.update(offset: 0)
                } else {
                    self?.detailLabelTopConstraint?.update(offset: DetailLabelTopOffset)
                }
            }
        }

        detailAttributeTextObserver = detailLabel.observe(\UILabel.attributedText) {[weak self] (label, _) in
            let text = label.text
            guard text != nil else { return }
            if (text?.isEmpty)! {
                self?.detailLabelTopConstraint?.update(offset: 0)
            } else {
                guard self?.titleLabel.text != nil else {
                    self?.detailLabelTopConstraint?.update(offset: 0)
                    return
                }
                if (self?.titleLabel.text?.isEmpty) == true {
                    self?.detailLabelTopConstraint?.update(offset: 0)
                } else {
                    self?.detailLabelTopConstraint?.update(offset: DetailLabelTopOffset)
                }
            }
        }
    }
}

extension TwoButtonAlertView {
    @objc func rightAction() {
        self.hiddenAlertView()
        if self.rightButtonBlock != nil {
            self.rightButtonBlock!()
        }
    }

    @objc func leftAction() {
        self.hiddenAlertView()
        if self.leftButtonBlock != nil {
            self.leftButtonBlock!()
        }
    }
}

