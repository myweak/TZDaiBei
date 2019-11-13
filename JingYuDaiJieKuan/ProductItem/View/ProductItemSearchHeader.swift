//
//  ProductItemSearchHeader.swift
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/4.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

import UIKit

class ProductItemSearchHeader: UICollectionReusableView {
    lazy var titleLbl: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    ///点击了广告的闭包
    public var deleteClosure: (() -> Void)?
    
    /// 是否隐藏删除按钮
    var isHiddenCloseBtn: Bool = false {
            didSet {
             deleteBtn.isHidden = isHiddenCloseBtn
            }
        }
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(didClickDelete), for: .touchUpInside)
        btn.setImage(UIImage(named: "history_close"), for: .normal)
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubViews() {
        addSubview(titleLbl)
        addSubview(deleteBtn)
        
        titleLbl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        deleteBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(15)
        }
        
    }
    
    // 删除按钮
    @objc func didClickDelete () {
        if let deleteClosure = deleteClosure {
            deleteClosure()
        }
    }
}
