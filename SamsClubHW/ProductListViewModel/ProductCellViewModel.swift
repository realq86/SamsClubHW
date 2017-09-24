//
//  ProductCellViewModel.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/23/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import Foundation


protocol ProductCellViewModelProtocol {
    var name: String { get }
}

class ProductCellViewModel: ProductCellViewModelProtocol {
    
    var name: String {
        get {
            return self.model.name
        }
    }
    
    var model: SamProductModelProtocol!
    
    init(model: SamProductModelProtocol) {
        self.model = model
    }
}
