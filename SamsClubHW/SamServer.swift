//
//  SamServer.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/22/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import Foundation

enum APIError: Error {
    case badURLString(String)
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
        print("GetProducts = \(urlString)")
        guard let url = URL(string:urlString)
            else {
                let error = APIError.badURLString(urlString)
                completion([SamProduct](), error)
                return
        }
        
        urlSession.dataTask(with: url) { [unowned self] (data, response, dataError) in
            
            var products = [SamProduct]()
            
            guard dataError == nil
                else {
                    completion(products, dataError)
                    return
            }
        
            guard let data = data
                else {
                    completion(products, nil)
                    return
            }
            
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



