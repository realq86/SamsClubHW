//
//  SamsClubHWTests.swift
//  SamsClubHWTests
//
//  Created by Chi Hwa Michael Ting on 9/22/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import XCTest
@testable import SamsClubHW

class SamsClubHWTests: XCTestCase {
    
    let server = SamServer.shared
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetProductListNotNil() {
        
        let expectation = self.expectation(description: "Response is not nil")
        
        server.getProductList(atPage: 1, length: 10) { (products, error) in
            if error == nil {
                expectation.fulfill()
            }
            else {
                print(error?.localizedDescription ?? "")
            }
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testGetProductListVarifyFirstProduct() {
        
        let expectationsName = ["ProductID", "Name", "Short", "Long", "Price", "ImageURL", "InStock", "Rating", "RatingCount"]
        var expectations = [String: XCTestExpectation]()
        for name in expectationsName {
            expectations[name] = self.expectation(description: name)
        }
        
        server.getProductList(atPage: 0, length: 10) { (products, error) in
            
            guard let firstProduct = products.first as? Product
                else { return }
            
            if firstProduct.productID != "" {
                print("PRODUCT ID = \(firstProduct.productID)")
                expectations["ProductID"]!.fulfill()
            }
            
            if firstProduct.name != "" {
                expectations["Name"]!.fulfill()
            }
            
            if firstProduct.shortDescrip != NSAttributedString(string: "") {
                expectations["Short"]!.fulfill()
            }
            
            if firstProduct.longDescrip != NSAttributedString(string: "") {
                expectations["Long"]!.fulfill()
            }
            
            if firstProduct.price != "" {
                expectations["Price"]!.fulfill()
            }
            
            if firstProduct.imageURL != URL(string: "") {
                expectations["ImageURL"]!.fulfill()
            }
            
            if firstProduct.inStock || !firstProduct.inStock  {
                expectations["InStock"]!.fulfill()
            }
            
            if let rating = firstProduct.reviewRating {
                if rating >= 0 || rating <= 10 {
                    expectations["Rating"]!.fulfill()
                }
            }
            else {
                expectations["Rating"]!.fulfill()
            }

            
            if firstProduct.reviewCount >= 0 {
                expectations["RatingCount"]!.fulfill()
            }
        }
        self.wait(for: Array(expectations.values), timeout: 5)
    }
    
    func testPagingProductlist() {
        
        let expectation = self.expectation(description: "Verify paging")
        
        var productsList = [SamProduct]()
        
        server.getProductList(atPage: 0, length: 10) { (products, error) in
            guard error == nil
                else { return }
            productsList.append(contentsOf: products)
            
            self.server.getProductList(atPage: 1, length: 10, completion: { (nextProducts, error) in
                productsList.append(contentsOf: nextProducts)
                
                if productsList.count == 20 {
                    
                    let first = productsList[0] as! Product
                    let eleventh = productsList[10] as! Product
                    
                    if first.productID != eleventh.productID {
                        expectation.fulfill()
                    }
                }
                print(productsList)
            })
        }
        self.wait(for: [expectation], timeout: 50)
    }
    
    
    func testCellVM() {
        
        let expect = self.expectation(description: "Verify CellVM Init")
        
        var pass = 0
        
        let dic = [kProductID: "123", kProductName: "TestName", kPrice: "$1000.91", kInStock: false, kReviewRating: 1.2, kReviewCount: 987] as [String : AnyObject]
        
        let productMock = Product(dic)
        
        let productVM = ProductViewModel(model: productMock, dataProvider:server)
        
        if productVM.name.value == "TestName" {
            pass += 1
        }
        
        if productVM.price.value == "$1000.91" {
            pass += 1
        }
        
        if productVM.inSTock.value == false {
            pass += 1
        }
        
        if productVM.reviewRating.value == 1.2 {
            pass += 1
        }
        
        print(pass)
        if pass == 4 {
            expect.fulfill()
        }
        
        self.wait(for: [expect], timeout: 1)
    }
    
    func testfetchFreshModel() {
        
        let expect = self.expectation(description: "Verify ListVM to CellVM init")
        
        let listVM = ProductListViewModel(dataProvider: server)
        
        listVM.dataBackArray.bind(onChange: { (productVMs) in
            guard !productVMs.isEmpty
                else { return }
            
            let productVM = productVMs[0]
            
            if productVM.name.value == "" {
                return
            }
            
            if productVM.shortDescrip.value == NSAttributedString(string: "") {
                return
            }
            
            if productVM.price.value == "" {
                return
            }
            expect.fulfill()
        })
        
        listVM.fetchFreshModel { (ifError) in
            guard ifError == false
                else { return }
        }
        
        self.wait(for: [expect], timeout: 50)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
