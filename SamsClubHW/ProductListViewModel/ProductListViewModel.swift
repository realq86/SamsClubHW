//
//  ProductListViewModel.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/23/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import Foundation

let kMockNetworkDelaySec: Double = 1

protocol ProductListDisplay {
    var dataBackArray: DataBinder<[ProductDisplay]> { get }
    var isLoadingData: DataBinder<Bool> { get }
    init(dataProvider: SamServer)
    func fetchFreshModel(ifError: @escaping (Bool)->Void)
    func fetchNextPage(ifError: @escaping (Bool)->Void)
    func modelAt(_ index: Int) -> AnyObject?
    func addModel(_ model:Any)
}

class ProductListViewModel: ProductListDisplay {
    
    fileprivate var currentPage = 1
    fileprivate var dataProvider: SamServer!
    fileprivate var models: [SamProduct] {
        didSet {
            var tempArray = [ProductCellViewModel]()
            for model in models {
                tempArray.append(ProductCellViewModel(model: model, dataProvider:dataProvider))
            }
            dataBackArray.value = tempArray
        }
    }
    
    var dataBackArray: DataBinder<[ProductDisplay]>
    
    var isLoadingData = DataBinder(value: false)
    
    required init(dataProvider: SamServer) {
        self.dataProvider = dataProvider
        self.dataBackArray = DataBinder(value: [ProductCellViewModel]())
        self.models = [SamProduct]()
    }
    
    func fetchFreshModel(ifError: @escaping (Bool) -> Void) {
        self.currentPage = 1
        fetchNextPage { (error) in
            ifError(error)
        }
    }
    
    func fetchNextPage(ifError: @escaping (Bool) -> Void) {
        isLoadingData.value = true
        dataProvider.getProductList(atPage: currentPage, length: 10) { (products, error) in
            DispatchQueue.main.asyncAfter(deadline: .now()+kMockNetworkDelaySec, execute: { [weak self] in
                if error != nil {
                    ifError(true)
                    return
                }
                ifError(false)
                self?.models.append(contentsOf: products)
                self?.currentPage += 1
                self?.isLoadingData.value = false
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
    
    func addModel(_ model: Any) {
        //UNUSED
    }

}
