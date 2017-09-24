//
//  SamJsonToModel.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/22/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import Foundation
import UIKit
enum JsonToModel: Error {
    case productListError
}

class SamJsonToModel {
    
    static func productListFrom(_ jsonResponse: AnyObject?) throws -> [SamProduct]{
        var products = [SamProduct]()
        
        guard let responseArray = jsonResponse as? [String:Any], let productsArray = responseArray[kProducts] as? [[String: AnyObject]]
            else {
                throw JsonToModel.productListError
        }
        
        for eachProductDic in productsArray {
            products.append(SamProduct(eachProductDic))
        }
        
        return products
    }
}

struct SamProduct {
    
    var productID: String
    var name: String
    var shortDescrip: NSAttributedString
    var longDescrip: NSAttributedString
    var price: String
    var imageURL: URL?
    var inStock: Bool
    var reviewRating: Float?
    var reviewCount: Int
    
    init(_ dic:[String: AnyObject]) {
        
        productID = dic[kProductID] as? String ?? ""
        name = dic[kProductName] as? String ?? ""
        
        let shortDescripStr = dic[kShortDescription] as? String ?? ""
        shortDescrip = StringFrom(html: shortDescripStr)
        
        let longDescripStr = dic[kLongDescription] as? String ?? ""
        longDescrip = StringFrom(html: longDescripStr)
        
        price = dic[kPrice] as? String ?? "n\\a"
        
        imageURL = URL(string: dic[kImage] as? String ?? "")
        
        inStock = dic[kInStock] as? Bool ?? false
        
        reviewCount = dic[kReviewCount] as? Int ?? 0
        if reviewCount > 0 {
            reviewRating = dic[kReviewRating] as? Float ?? 0.0
        }        
    }
}

func StringFrom(html: String) -> NSAttributedString {
    
    guard let data = html.data(using: String.Encoding.utf8, allowLossyConversion: true)
        else { return NSAttributedString(string: "") }
    
    do {
        return try NSAttributedString(data: data,
                                      options:[.documentType:NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
    catch {
        return NSAttributedString(string: "")
    }
}
