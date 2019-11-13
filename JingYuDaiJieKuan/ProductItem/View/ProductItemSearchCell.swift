//
//  ProductItemSearchCell.swift
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/4.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

import UIKit

class ProductItemSearchCell: UICollectionViewCell {
    lazy var titleLbl: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.layer.borderWidth = 0.2
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubViews() {
        self.contentView.addSubview(titleLbl)
        
        titleLbl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
}
