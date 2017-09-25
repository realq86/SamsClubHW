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
    
    var viewModel: ProductDisplay! {
        didSet {
            
            //Bind Product Name to Label
            viewModel.name.bind { (name) in
                self.productNameLabel.text = String(name.utf16)
            }
            
            //Bind Rating to Label
            viewModel.reviewRating.bind { (rating) in
                if let rating = rating {
                    self.ratingLabel.text = String(rating)
                }
            }
            
            //Bind Price to Label
            viewModel.price.bind { (price) in
                self.priceLabel.text = price
            }
            
            //Bind inStock to Label
            viewModel.inSTock.bind { (inStock) in
                self.inStockLabel.text = inStock ? "YES" : "NO"
            }
            
            //Bind Short Description to Label
            viewModel.shortDescrip.bind { (attributedString) in
                if attributedString.string != "" {
                    self.shortDescripLabel.text = attributedString.string
                }
                else {
                    self.shortDescripLabel.isHidden = true
                }
            }

            //Bind Image to UIImageView
            viewModel.image.bind { [weak self] (image) in
                self?.productImageView.image = self?.viewModel.image.value
            }
        }
    }
    
    override func prepareForReuse() {
        
        /* Resetting all field to empty and unlisten any async properties */
        
        self.productNameLabel.text = ""
        self.ratingLabel.text = ""
        self.priceLabel.text = ""
        self.inStockLabel.text = ""
        self.shortDescripLabel.text = ""
        self.imageView?.image = nil
        
        //Unbind the image download overservated as this cell is used for another model
        self.viewModel.image.onChange = nil
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
