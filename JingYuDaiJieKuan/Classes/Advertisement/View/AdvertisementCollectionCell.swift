//
//  AdvertisementCollectionCell.swift
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/4.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

import UIKit

class AdvertisementCollectionCell: UICollectionViewCell {
    lazy var imageView: UIImageView  = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubViews() {
//        contentView.backgroundColor = .white
        self.contentView.addSubview(imageView)
     
        imageView.snp.makeConstraints { (make) in
           make.edges.equalToSuperview()
        }
       
    }
}
