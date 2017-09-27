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
let kDownloadPageSize = 10

protocol ProductListDisplay {
    var dataBackArray: DataBinder<[ProductDisplay]> { get }
    var isLoadingData: DataBinder<Bool> { get }
    init(dataProvider: SamServer)
    func fetchFreshModel(ifError: @escaping (Bool)->Void)
    func fetchNextPage(ifError: @escaping (Bool)->Void)
    func modelAt(_ index: Int) -> SamProduct?
    func removeData(at index: Int)
    func addModel(_ model:Any)
    func color(at index: Int) -> UIColor
}

class ProductListViewModel: ProductListDisplay {
    
    fileprivate var currentPage = 1
    fileprivate var dataProvider: SamServer!
    fileprivate var models: [SamProduct]
//    {
//        didSet {
//            var tempArray = [ProductViewModel]()
//            for model in models {
//                tempArray.append(ProductViewModel(model: model, dataProvider:dataProvider))
//            }
//            dataBackArray.value = tempArray
//        }
//    }
    
    var dataBackArray: DataBinder<[ProductDisplay]>
    
    var isLoadingData = DataBinder(value: false)
    
    required init(dataProvider: SamServer) {
        self.dataProvider = dataProvider
        self.dataBackArray = DataBinder(value: [ProductViewModel]())
        self.models = [SamProduct]()
    }
    
    func fetchFreshModel(ifError: @escaping (Bool) -> Void) {
        self.currentPage = 1
        self.models.removeAll()
        self.dataBackArray.value.removeAll()
        
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
        dataProvider.getProductList(atPage: currentPage, length: kDownloadPageSize) { (products, error) in
            DispatchQueue.main.asyncAfter(deadline: .now()+kMockNetworkDelaySec, execute: { [weak self] in
                if error != nil {
                    ifError(true)
                    return
                }
                ifError(false)
                self?.models.append(contentsOf: products)
                var tempArray = [ProductDisplay]()
                for product in products {
                    let productVM = ProductViewModel(model: product, dataProvider: self!.dataProvider)
                    tempArray.append(productVM)
                }
                self?.dataBackArray.value.append(contentsOf: tempArray)
                self?.currentPage += 1
                
                //Give TableView a chance to layout before allowing next download.
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    self?.isLoadingData.value = false
                })
            })
        }
    }
    
    func modelAt(_ index: Int) -> SamProduct? {
        if index < self.models.count {
            let model = self.models[index]
            return model as SamProduct
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
        let count = Float(dataBackArray.value.count)
        
        let indexFloat = Float(index)
        let stepConstant: Float = 0.4
        let gradiant = CGFloat(count / (count-indexFloat*stepConstant) )
        
        return UIColor(red: (78*gradiant)/255, green: (147*gradiant)/255, blue: (48*gradiant)/255, alpha: 1)
    }

}
