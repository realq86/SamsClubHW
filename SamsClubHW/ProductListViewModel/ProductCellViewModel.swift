//
//  ProductCellViewModel.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/23/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import Foundation
import UIKit

protocol ProductDisplay {
    var name: DataBinder<String> { get }
    var shortDescrip: DataBinder<NSAttributedString> { get }
    var price: DataBinder<String> { get }
    var image: DataBinder<UIImage> { get }
    var inSTock: DataBinder<Bool> { get }
    var reviewRating: DataBinder<Float?> { get }
}

class ProductCellViewModel: ProductDisplay {
    var name: DataBinder<String>
    
    var shortDescrip: DataBinder<NSAttributedString>
    
    var price: DataBinder<String>
    
    var image: DataBinder<UIImage>
    
    var inSTock: DataBinder<Bool>
    
    var reviewRating: DataBinder<Float?>
    
    var model: SamProduct!
    
    init(model: SamProduct) {
        self.model = model
        
        name = DataBinder(value: model.name)
        shortDescrip = DataBinder(value: model.shortDescrip)
        price = DataBinder(value: model.price)
        image = DataBinder(value: #imageLiteral(resourceName: "placeHolder"))
        inSTock = DataBinder(value: model.inStock)
        reviewRating = DataBinder(value: model.reviewRating)
    }
    
    
}
