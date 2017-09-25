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
    @IBOutlet var ratingContainer: UIView!
    @IBOutlet var inStockContainer: UIView!
    
    var viewModel: ProductDisplay! {
        didSet {
            
            //Bind Product Name to Label
            viewModel.name.bind { [unowned self] (name) in
                self.productNameLabel.text = String(name.utf16)
            }
            
            //Bind Rating to Label
            viewModel.reviewRating.bind { [unowned self] (rating) in
                if let rating = rating {
                    self.ratingLabel.text = String(format:"%.2f", rating)
                }
            }
            
            //Bind Price to Label
            viewModel.price.bind { [unowned self] (price) in
                self.priceLabel.text = price
            }
            
            //Bind inStock to Label
            viewModel.inSTock.bind { [unowned self] (inStock) in
                self.inStockLabel.text = inStock ? "YES" : "NO"
            }
            
            //Bind Short Description to Label
            viewModel.shortDescrip.bind { [unowned self] (attributedString) in
                if attributedString.string != "" {
                    self.shortDescripLabel.text = attributedString.string
                }
                else {
                    self.shortDescripLabel.isHidden = true
                }
            }

            //Bind Image to UIImageView
            viewModel.image.bind { [unowned self] (image) in
                self.productImageView.image = image
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
        
//        self.contentView.layer.cornerRadius = 20
        
        self.productNameLabel.layer.cornerRadius = 5
        self.productImageView.layer.cornerRadius = 5
       
        self.priceLabel.layer.cornerRadius = 5
        self.shortDescripLabel.layer.cornerRadius = 5
        
        self.ratingContainer.layer.cornerRadius = 5
        self.inStockContainer.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
