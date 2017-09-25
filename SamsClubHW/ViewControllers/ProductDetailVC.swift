//
//  ProductDetailVC.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/25/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var ratingCountLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var inStockLabel: UILabel!
    @IBOutlet var longDescriptionLabel: UILabel!
    
    var product:SamProduct!
    var viewModel: ProductDisplay = ProductViewModel(model:Product(nil), dataProvider: SamServer.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Bind product name to VC title
        viewModel.name.bind { [unowned self] (name) in
            self.title = name
        }
        
        //Bind Product Image
        viewModel.image.bind { [unowned self] (image) in
            self.productImageView.image = image
        }
        
        //Bind Review Rating
        viewModel.reviewRating.bind { [unowned self] (rating) in
            if let rating = rating {
                self.ratingLabel.text = String(format:"%.2f", rating)
            }
        }
        
        //Bind ReviewCount
        viewModel.reviewCount.bind { [unowned self] (count) in
            self.ratingCountLabel.text = String(count)
        }
        
        //Bind Price to Label
        viewModel.price.bind { [unowned self] (price) in
            self.priceLabel.text = price
        }
        
        //Bind inStock to Label
        viewModel.inSTock.bind { [unowned self] (inStock) in
            self.inStockLabel.text = inStock ? "YES" : "NO"
        }
        
        //Bind Long Description to Label
        viewModel.longDescrip.bind { [unowned self] (attributedString) in
            if attributedString.string != "" {
                self.longDescriptionLabel.text = attributedString.string
            }
            else {
                self.longDescriptionLabel.isHidden = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}