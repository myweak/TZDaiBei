//
//  AppUpdateAlertView.swift
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/4.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

import UIKit

class AppUpdateAlertView: TDAlertCommonView {

    ///确认按钮的闭包
    public var sureUpdateClosure: (() -> Void)?
    
    ///取消按钮的闭包
    public var cancelClosure: (() -> Void)?
    
    ///
    private lazy var contentView: UIView = {
        let view = UIView()
       view.backgroundColor = UIColor.white
        return view
    }()
    
    ///背景图
    private lazy var bgImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "appupdate_bg"))
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    /// 更新内容标签
    private lazy var updateLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "更新内容"
        lbl.textColor = RGB(r: 52, g: 49, b: 50)
        return lbl
    }()
    
    /// 更新内容
    private lazy var updateText: UITextView = {
        let text = UITextView()
        return text
    }()
    
    ///更新按钮
    private lazy var sureUpdateButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "GuideBtnX"), for: .normal)
        button.setBackgroundImage(UIImage(named: "GuideBtnX"), for: .highlighted)
        button.setTitle("立即更新", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(didSureUpdateButton), for: .touchUpInside)
        return button
    }()
    
    ///取消按钮
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "appupdate_close"), for: .normal)
        button.addTarget(self, action: #selector(didCancelButton), for: .touchUpInside)
        return button
    }()
    
    @objc init(model: AppUpdateModel, cancelClosure: (() -> Void)? = nil, sureUpdateClosure: (() -> Void)? = nil) {
        super.init(animationStyle: .TDAlertFadePop, alertStyle: .TDAlertStyleAlert)
        self.sureUpdateClosure = sureUpdateClosure
        self.cancelClosure = cancelClosure
        setupSubViews()
        
        cancelButton.isHidden = model.upgradeWay == 2
        
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = 20
        //样式属性集合
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),
                          NSAttributedString.Key.foregroundColor: RGB(r: 90, g: 97, b: 98),
                          NSAttributedString.Key.paragraphStyle: paraph]
        
        updateText.attributedText = NSAttributedString(string: model.appDesc, attributes: attributes)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

///MARK: -设置UI
extension AppUpdateAlertView {
    private func setupSubViews() {
        
        addSubview(bgImageView)
        addSubview(contentView)
        contentView.addSubview(updateLbl)
        contentView.addSubview(updateText)
        contentView.addSubview(sureUpdateButton)
        addSubview(cancelButton)
        
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(123)
            make.width.equalTo(265)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(bgImageView.snp.bottom).offset(-6)
            make.left.right.equalTo(bgImageView)
            make.height.equalTo(230)
        }
        
        updateLbl.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(12)
            make.left.equalTo(contentView).offset(23)
            make.right.equalTo(contentView).offset(-23)
        }
        
        updateText.snp.makeConstraints { (make) in
            make.left.width.equalTo(updateLbl)
            make.top.equalTo(updateLbl.snp.bottom).offset(13)
            make.height.equalTo(117)
        }
        
        sureUpdateButton.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(12)
            make.right.equalTo(contentView).offset(-12)
            make.height.equalTo(45)
            make.top.equalTo(updateText.snp.bottom).offset(10)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.bottom).offset(29)
            make.centerX.equalTo(bgImageView)
            make.width.height.equalTo(32)
            make.bottom.equalTo(self)
        }
        
    }
}


///MARK: - 点击事件
extension AppUpdateAlertView {
    @objc func didCancelButton() {
        if let cancelClosure = cancelClosure {
            cancelClosure()
        }
        hiddenAlertView()
    }
    
    @objc func didSureUpdateButton() {
        if let sureUpdateClosure = sureUpdateClosure {
            sureUpdateClosure()
        }
//        hiddenAlertView()
    }
}
