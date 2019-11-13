//
//  ContinuedBalanceRetainAlertView.swift
//  XunHuiFinance
//
//  Created by dingtao on 2019/7/3.
//  Copyright © 2019 TDW.CN. All rights reserved.

import UIKit
import SnapKit


class AdvertisementAlertView: TDAlertCommonView,UITextFieldDelegate {
   
    ///取消按钮的闭包
    public var cancelButtonClosure: (() -> Void)?
    ///点击了广告的闭包
    public var showAdvClosure: ((Int) -> Void)?
    
    /// 一个collectionView
    private lazy var collctionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: cellW, height: cellH)
        flowLayout.minimumLineSpacing = 0.1
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = .zero
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = true
        collectionView.isPagingEnabled = true
        collectionView.register(AdvertisementCollectionCell.self, forCellWithReuseIdentifier: "AdvertisementCollectionCell")
        return collectionView
    }()
    
    ///取消按钮
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
//        button.setTitle("取消", for: .normal)
        button.setTitleColor(RGB(r: 153, g: 153, b: 153), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(didCancelButton), for: .touchUpInside)
        button.setImage(UIImage(named: "ggclose"), for: .normal)
        return button
    }()
    
    var images = [advertisementDialogModel]()
    @objc init(images: [advertisementDialogModel],
         cancelButtonClosure: (() -> Void)? = nil,
         showAdvClosure: ((Int) -> Void)? = nil) {
        super.init(animationStyle: .TDAlertFadePop, alertStyle: .TDAlertStyleAlert)
        self.cancelButtonClosure = cancelButtonClosure
        self.showAdvClosure = showAdvClosure
        self.images = images
        
        setupSubViews()
        
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

///MARK: - 点击事件
extension AdvertisementAlertView {
    @objc func didCancelButton() {
        hiddenAlertView()
    }
}


///MARK: -设置UI
extension AdvertisementAlertView {
    private func setupSubViews() {
//        backgroundColor = UIColor.white
        
        addSubview(collctionView)
        addSubview(cancelButton)
        
        collctionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalToSuperview()
            make.left.equalTo(self).offset(40)
            make.right.equalTo(self).offset(-40)
            make.height.equalTo(collctionView.snp.width).multipliedBy(900/795.0)
        }

        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(collctionView.snp.bottom).offset(13)
            make.centerX.equalTo(collctionView)
            make.width.height.equalTo(30)
            make.bottom.equalTo(self)
        }
        
    }
}


///MARK: dataSource/delegate
extension AdvertisementAlertView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvertisementCollectionCell", for: indexPath) as! AdvertisementCollectionCell
        if (TD_IPHONE_X) {
            if let url = URL(string: images[indexPath.item].photoIphonex) {
                cell.imageView.sd_setImage(with: url)
            }
        }else{
            if let url = URL(string: images[indexPath.item].photo) {
                cell.imageView.sd_setImage(with: url)
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let showAdvClosure = showAdvClosure {
            showAdvClosure(indexPath.item)
        }
        hiddenAlertView()
    }
    
}


///MARK: dataSource/delegate
extension AdvertisementAlertView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collctionView.bounds.size
    }
}
