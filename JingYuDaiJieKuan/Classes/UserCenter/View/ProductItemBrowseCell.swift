//
//  ProductItemBrowseCell.swift
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

import UIKit

class ProductItemBrowseCell: UITableViewCell {
    
    @IBOutlet var productImg: UIImageView!
    
    @IBOutlet var productName: UILabel!
    
    @IBOutlet var productTitle: UILabel!
    
    @IBOutlet var productMaxAmount: UILabel!
    
    var model: BrowseHistory? {
        didSet {
            guard let model = model else { return }
            if let urlstr = model.icon, let imgUrl = URL(string: urlstr){
                productImg.sd_setImage(with: imgUrl)
            }
            productName.text = model.name
            productTitle.text = model.title
            productMaxAmount.text = "最高\(model.maxAmount)元"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    
}
