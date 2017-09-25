//
//  ProductCell.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/23/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var inStockLabel: UILabel!
    @IBOutlet var shortDescripLabel: UILabel!
    @IBOutlet var shortDescripContainer: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    
    var viewModel: ProductDisplay! {
        didSet {
            self.productNameLabel.text = String(viewModel.name.value.utf16)
            if let rating = viewModel.reviewRating.value {
                self.ratingLabel.text = String(rating)
            }
            self.ratingLabel.text = ""
            self.priceLabel.text = viewModel.price.value
            self.inStockLabel.text = viewModel.inSTock.value ? "YES" : "NO"
            
            if viewModel.shortDescrip.value.string != "" {
                self.shortDescripLabel.text = viewModel.shortDescrip.value.string
            }
            else {
//                self.shortDescripLabel.isHidden = true
            }
            
            self.productImageView.image = #imageLiteral(resourceName: "placeHolder")
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
