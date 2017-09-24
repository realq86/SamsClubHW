//
//  ProductCell.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/23/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    var viewModel: ProductDisplay! {
        didSet {
            self.titleLabel.text = viewModel.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
