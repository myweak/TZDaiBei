//
//  StreamerCell.swift
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/9/4.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

import UIKit

@objc class StreamerCell: UITableViewCell {

    @objc lazy var myImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage (named: "homepage_detail_place")
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none;
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func setupSubViews() {
        contentView.addSubview(myImageView)
        
        myImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(contentView).offset(13)
            make.bottom.equalTo(contentView)
            make.height.equalTo(83);
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self)
        }
    }
    
}
