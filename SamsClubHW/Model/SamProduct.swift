//
//  SamProduct.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/23/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import Foundation

protocol SamProduct {
    var name: String { get }
    var shortDescrip: NSAttributedString { get }
    var longDescrip: NSAttributedString { get }
    var price: String { get }
    var imageURL: URL? { get }
    var inStock: Bool { get }
    var reviewRating: Float? { get }
    var reviewCount: Int { get }
}

class Product: SamProduct {
    
    var productID: String
    var name: String
    var shortDescrip: NSAttributedString
    var longDescrip: NSAttributedString
    var price: String
    var imageURL: URL?
    var inStock: Bool
    var reviewRating: Float?
    var reviewCount: Int
    
    init(_ dic:[String: AnyObject]?) {
        
        productID = dic?[kProductID] as? String ?? ""
        name = dic?[kProductName] as? String ?? ""
//        name = StringFrom(html: nameHTML)
        
        let shortDescripStr = dic?[kShortDescription] as? String ?? ""
        shortDescrip = StringFrom(html: shortDescripStr)
        
        let longDescripStr = dic?[kLongDescription] as? String ?? ""
        longDescrip = StringFrom(html: longDescripStr)
        
        price = dic?[kPrice] as? String ?? ""
        
        imageURL = URL(string: dic?[kImage] as? String ?? "")
        
        inStock = dic?[kInStock] as? Bool ?? false
        
        reviewCount = dic?[kReviewCount] as? Int ?? 0
        if reviewCount > 0 {
            reviewRating = dic?[kReviewRating] as? Float ?? 0.0
        }
    }
}
