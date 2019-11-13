//
//  RandomMerchantAlertView.swift
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
import UIKit


class RandomMerchantAlertView: TDAlertCommonView {
    
    ///确认按钮的闭包
    public var sureUpdateClosure: (() -> Void)?
    
    ///取消按钮的闭包
    public var cancelClosure: (() -> Void)?
    
    ///背景图
    private lazy var bgImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "random_bg"))
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    /// icon
    private lazy var iconImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "random_logo"))
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    /// name
    private lazy var productNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    /// max
    private lazy var productMaxAmountLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = RGB(r: 53, g: 130, b: 246)
        return lbl
    }()
    
    /// count
    private lazy var productNumPeopleLbl: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    ///更新按钮
    private lazy var sureEnterButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "GuideBtnX"), for: .normal)
        button.setBackgroundImage(UIImage(named: "GuideBtnX"), for: .highlighted)
        button.setTitle("去拿钱", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(didSureEnterButton), for: .touchUpInside)
        return button
    }()
    
    ///取消按钮
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("不感兴趣", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.addTarget(self, action: #selector(didCancelButton), for: .touchUpInside)
        return button
    }()
    
    @objc var model: randomProductModel? {
        didSet {
            guard let model = model else { return }
            if let imgUrl = URL(string: model.icon){
                iconImageView.sd_setImage(with: imgUrl)
            }
            productNameLbl.text = model.name
            
            /// 最高贷款
            let imageAttachment : NSTextAttachment = NSTextAttachment()
            imageAttachment.image =  UIImage(named: "random_star")
            imageAttachment.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
            let mustrAtt = NSMutableAttributedString(attributedString: NSAttributedString(attachment: imageAttachment))
            mustrAtt.append(NSAttributedString(string: " 最高贷款:\(model.maxAmount)"))
            //设置颜色
            mustrAtt.addAttribute(.foregroundColor, value: UIColor.black, range: NSMakeRange(1, 5))
            productMaxAmountLbl.attributedText = mustrAtt
         
            /// 下款人数
            let imageAttachmentPeople : NSTextAttachment = NSTextAttachment()
            imageAttachmentPeople.image =  UIImage(named: "random_star")
            imageAttachmentPeople.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
            let mustrAttPeople = NSMutableAttributedString(attributedString: NSAttributedString(attachment: imageAttachment))
            mustrAttPeople.append(NSAttributedString(string: " 今日下款人数:\(model.numPeople)人"))
            productNumPeopleLbl.attributedText = mustrAttPeople
        }
    }
    
    @objc init(isHiddenCancelButton: Bool = false, cancelClosure: (() -> Void)? = nil, sureUpdateClosure: (() -> Void)? = nil) {
        super.init(animationStyle: .TDAlertFadePop, alertStyle: .TDAlertStyleAlert)
        self.sureUpdateClosure = sureUpdateClosure
        self.cancelClosure = cancelClosure
        setupSubViews()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

///MARK: -设置UI
extension RandomMerchantAlertView {
    private func setupSubViews() {
        
        addSubview(bgImageView)
        bgImageView.addSubview(iconImageView)
        bgImageView.addSubview(productNameLbl)
        bgImageView.addSubview(productMaxAmountLbl)
        bgImageView.addSubview(productNumPeopleLbl)
        bgImageView.addSubview(sureEnterButton)
        bgImageView.addSubview(cancelButton)
        
        
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalToSuperview()
            make.height.equalTo(bgImageView.snp.width).multipliedBy(823/628.0)
            make.width.equalTo(315)
            make.bottom.equalTo(self)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.centerX.equalTo(bgImageView)
            make.top.equalTo(bgImageView).offset(50)
        }
        
        productNameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(40)
            make.width.equalTo(bgImageView).multipliedBy(0.7)
            make.centerX.equalTo(bgImageView)
        }
        
        productMaxAmountLbl.snp.makeConstraints { (make) in
            make.top.equalTo(productNameLbl.snp.bottom).offset(44)
            make.centerX.width.equalTo(productNameLbl)
        }
        
        productNumPeopleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(productMaxAmountLbl.snp.bottom).offset(16)
            make.centerX.width.equalTo(productNameLbl)
        }
        
        sureEnterButton.snp.makeConstraints { (make) in
            make.left.equalTo(bgImageView).offset(42)
            make.right.equalTo(bgImageView).offset(-42)
            make.height.equalTo(45)
            make.bottom.equalTo(cancelButton.snp.top).offset(-20)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.height.equalTo(18)
            make.left.equalTo(sureEnterButton)
            make.right.equalTo(sureEnterButton)
            make.bottom.equalTo(bgImageView).offset(-20)
        }
        
    }
}


///MARK: - 点击事件
extension RandomMerchantAlertView {
    @objc func didCancelButton() {
        if let cancelClosure = cancelClosure {
            cancelClosure()
        }
        hiddenAlertView()
        
        //埋点
        if let name = model?.name, let id = model?.merchartid{
            SensorsAnalyticsSDKHelper.trackAdWebView(custemName: name, isBrowse: false, mchId: id, mchName: name)
        }
        
    }
    
    @objc func didSureEnterButton() {
        if let sureUpdateClosure = sureUpdateClosure {
            sureUpdateClosure()
        }
        hiddenAlertView()
        
        //埋点
        if let name = model?.name, let id = model?.merchartid{
            SensorsAnalyticsSDKHelper.trackAdWebView(custemName: name, isBrowse: true, mchId: id, mchName: name)
        }
    }
}

