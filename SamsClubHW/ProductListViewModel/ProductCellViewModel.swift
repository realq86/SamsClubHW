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
    
    var dataProvider: SamServer
    
    var name: DataBinder<String>
    
    var shortDescrip: DataBinder<NSAttributedString>
    
    var price: DataBinder<String>
    
    var downloaded = false
    fileprivate var _image: DataBinder<UIImage>
    var image: DataBinder<UIImage> {
        get {
            if !downloaded {
                downloadImage()
            }
            return _image
        }
        set {
            _image = newValue
        }
    }
    
    var inSTock: DataBinder<Bool>
    
    var reviewRating: DataBinder<Float?>
    
    var model: SamProduct!
    
    init(model: SamProduct, dataProvider: SamServer) {
        self.dataProvider = dataProvider
        self.model = model
        name = DataBinder(value: model.name)
        shortDescrip = DataBinder(value: model.shortDescrip)
        price = DataBinder(value: model.price)
        _image = DataBinder(value: #imageLiteral(resourceName: "placeHolder"))
        inSTock = DataBinder(value: model.inStock)
        reviewRating = DataBinder(value: model.reviewRating)
    }
    
    func downloadImage() {
        if downloaded {
            return
        }
        if let url = model.imageURL {
            dataProvider.downloadImage(with: url, completion: { (image, error) in
                if let image = image {
                    DispatchQueue.main.async { [weak self] in
                        self?.image.value = image
                        self?.downloaded = true
                    }
                }
            })
        }
    }
}
