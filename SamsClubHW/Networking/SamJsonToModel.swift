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
