//
//  ProductListViewModel.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/23/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import Foundation
import UIKit

let kMockNetworkDelaySec: Double = 0

protocol ProductListDisplay {
    var dataBackArray: DataBinder<[ProductDisplay]> { get }
    var isLoadingData: DataBinder<Bool> { get }
    init(dataProvider: SamServer)
    func fetchFreshModel(ifError: @escaping (Bool)->Void)
    func fetchNextPage(ifError: @escaping (Bool)->Void)
    func modelAt(_ index: Int) -> AnyObject?
    func addModel(_ model:Any)
    func color(at index: Int) -> UIColor
}

class ProductListViewModel: ProductListDisplay {
    
    fileprivate var currentPage = 1
    fileprivate var dataProvider: SamServer!
    fileprivate var models: [SamProduct] {
        didSet {
            var tempArray = [ProductViewModel]()
            for model in models {
                tempArray.append(ProductViewModel(model: model, dataProvider:dataProvider))
            }
            dataBackArray.value = tempArray
        }
    }
    
    var dataBackArray: DataBinder<[ProductDisplay]>
    
    var isLoadingData = DataBinder(value: false)
    
    required init(dataProvider: SamServer) {
        self.dataProvider = dataProvider
        self.dataBackArray = DataBinder(value: [ProductViewModel]())
        self.models = [SamProduct]()
    }
    
    func fetchFreshModel(ifError: @escaping (Bool) -> Void) {
        self.currentPage = 1
        fetchNextPage { (error) in
            ifError(error)
        }
    }
    
    func fetchNextPage(ifError: @escaping (Bool) -> Void) {
        
        guard isLoadingData.value == false
            else {
                ifError(false)
                return
        }
        
        isLoadingData.value = true
        dataProvider.getProductList(atPage: currentPage, length: 3) { (products, error) in
            DispatchQueue.main.asyncAfter(deadline: .now()+kMockNetworkDelaySec, execute: { [weak self] in
                if error != nil {
                    ifError(true)
                    return
                }
                ifError(false)
                self?.models.append(contentsOf: products)
                self?.currentPage += 1
                
                //Give TableView a chance to layout before allowing next download.
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    self?.isLoadingData.value = false
                })
            })
        }
    }
    
    func modelAt(_ index: Int) -> AnyObject? {
        if index < self.models.count {
            let model = self.models[index]
            return model as AnyObject
        }
        return nil
    }
    
    func removeData(at index: Int) {
        if index < self.models.count {
            self.dataBackArray.value.remove(at: index)
        }
    }
    
    func addModel(_ model: Any) {
        //UNUSED
    }

    func color(at index: Int) -> UIColor {
        let count = dataBackArray.value.count
        var gradiant = CGFloat(Float(index)*1.2)/CGFloat(count)*0.6
    
        var alpha = (1 - gradiant)
//        alpha = 1
        return UIColor(red: 78/255, green: 147/255, blue: 48/255, alpha: alpha*0.7)
    }
    
    
}
