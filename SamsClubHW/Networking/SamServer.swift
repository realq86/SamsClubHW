//
//  SamServer.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/22/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import Foundation
import UIKit

enum APIError: Error {
    case badURLString(String)
    case dataNilError
    case jsonParseError
}

class SamServer {
    static var shared = SamServer()
    fileprivate let urlSession = URLSession.shared
}

extension SamServer {
    
    typealias getProductsCompletion = ([SamProduct], Error?) -> Void
    
    func getProductList(atPage page:Int, length:Int, completion:@escaping getProductsCompletion) {
        
        let urlString = kSamClubAPIBaseURL + kGetProductList + "\(page)" + "/\(length)"
//        print("GetProducts = \(urlString)")
        guard let url = URL(string:urlString)
            else {
                let error = APIError.badURLString(urlString)
                completion([SamProduct](), error)
                return
        }
        
        urlSession.dataTask(with: url) { [unowned self] (data, response, dataError) in
            
            var products = [SamProduct]()
            
            //DataTask Error
            guard dataError == nil
                else {
                    completion(products, dataError)
                    return
            }
        
            //Nil Data
            guard let data = data
                else {
                    completion(products, APIError.dataNilError)
                    return
            }
            
            //Json Parsing and Model Conversion
            do {
                let jsonResponse = try self.parseJsonFrom(data)
                products = try SamJsonToModel.productListFrom(jsonResponse)
                completion(products, nil)
            }
            catch {
                completion(products, error)
            }
        }.resume()
    }
    
    typealias ImageDownloadComplete = (UIImage?, Error?)->Void
    func downloadImage(with url:URL, completion: @escaping ImageDownloadComplete) {
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil && data != nil{
                completion(nil, error)
                return
            }
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.global().asyncAfter(deadline: .now(), execute: {
                    completion(image, error)
                })
            }
            }.resume()
    }
    
    func parseJsonFrom(_ data:Data) throws -> AnyObject {
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)) as AnyObject
            print(jsonResponse.description)
            return jsonResponse
        }
        catch {
            throw APIError.jsonParseError
        }
    }
}



