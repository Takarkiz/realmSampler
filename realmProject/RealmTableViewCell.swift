//
//  RealmTableViewCell.swift
//  realmProject
//
//  Created by 澤田昂明 on 2017/12/05.
//  Copyright © 2017年 澤田昂明. All rights reserved.
//

import UIKit

class RealmTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var contentsLabel:UILabel!
    @IBOutlet var themeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
