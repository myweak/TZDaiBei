//
//  CustomeServiceAlert.swift
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/16.
//  Copyright © 2019 Jincaishen. All rights reserved.
//  专属客服弹窗

import UIKit


class CustomeServiceAlert: TDAlertCommonView {
    
    ///确认按钮的闭包
    public var sureUpdateClosure: (() -> Void)?
    
    ///背景图
    private lazy var bgImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "bg_customeService"))
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
   
    ///确定按钮
    private lazy var sureEnterButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = RGB(r: 242, g: 170, b: 93)
        button.setTitle("去微信", for: .normal)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(didSureEnterButton), for: .touchUpInside)
        return button
    }()
    
    @objc init(sureUpdateClosure: (() -> Void)? = nil) {
        super.init(animationStyle: .TDAlertFadePop, alertStyle: .TDAlertStyleAlert)
        self.sureUpdateClosure = sureUpdateClosure
        setupSubViews()
        
        self.backgroundAction = {
            self.hiddenAlertView()
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

///MARK: -设置UI
extension CustomeServiceAlert {
    private func setupSubViews() {
        
        addSubview(bgImageView)
        bgImageView.addSubview(sureEnterButton)
        
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalToSuperview()
            make.height.equalTo(bgImageView.snp.width).multipliedBy(823/628.0)
            make.width.equalTo(315)
            make.bottom.equalTo(self)
        }
        
        sureEnterButton.snp.makeConstraints { (make) in
            make.left.equalTo(bgImageView).offset(42)
            make.right.equalTo(bgImageView).offset(-42)
            make.bottom.equalTo(bgImageView).offset(-42)
            make.height.equalTo(44)
        }
        
    }
}


///MARK: - 点击事件
extension CustomeServiceAlert {
   
    @objc func didSureEnterButton() {
        if let sureUpdateClosure = sureUpdateClosure {
            sureUpdateClosure()
        }
        hiddenAlertView()
        
    }
}

