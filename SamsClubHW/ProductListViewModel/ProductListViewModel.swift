//
//  ProductListViewModel.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/23/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import Foundation

let kMockNetworkDelaySec: Double = 1

protocol ProductListViewModelProtocol {
    var dataBackArray: DataBinder<[ProductCellViewModelProtocol]> { get }
    var isLoadingData: DataBinder<Bool> { get }
    init(dataProvider: SamServer)
    func fetchFreshModel(ifError: @escaping (Bool)->Void)
    func fetchNextPage(ifError: @escaping (Bool)->Void)
    func modelAt(_ index: Int) -> AnyObject?
    func addModel(_ model:Any)
}

class ProductListViewModel: ProductListViewModelProtocol {
    
    fileprivate var currentPage = 1
    fileprivate var dataProvider: SamServer!
    fileprivate var models: [SamProductModelProtocol] {
        didSet {
            var tempArray = [ProductCellViewModel]()
            for model in models {
                tempArray.append(ProductCellViewModel(model: model))
            }
            dataBackArray.value = tempArray
        }
    }
    
    var dataBackArray: DataBinder<[ProductCellViewModelProtocol]>
    
    var isLoadingData = DataBinder(value: false)
    
    required init(dataProvider: SamServer) {
        self.dataProvider = dataProvider
        self.dataBackArray = DataBinder(value: [ProductCellViewModel]())
        self.models = [SamProductModelProtocol]()
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
                self?.models = products
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
