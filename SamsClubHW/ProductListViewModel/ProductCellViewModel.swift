//
//  ProductCellViewModel.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/23/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import Foundation


protocol ProductDisplay {
    var name: String { get }
}

class ProductCellViewModel: ProductDisplay {
    
    var name: String {
        get {
            return self.model.name
        }
    }
    
    var model: SamProduct!
    
    init(model: SamProduct) {
        self.model = model
    }
}
