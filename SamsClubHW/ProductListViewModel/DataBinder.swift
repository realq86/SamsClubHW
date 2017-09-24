//
//  DataBinder.swift
//  SamsClubHW
//
//  Created by Chi Hwa Michael Ting on 9/23/17.
//  Copyright © 2017 Chi Hwa Michael Ting. All rights reserved.
//

import Foundation

class DataBinder<T> {
    
    var value:T {
        didSet {
            onChange?(value)
        }
    }
    
    typealias onChangeClosure = (T)->Void
    var onChange: onChangeClosure?
    
    init(value:T) {
        self.value = value
    }
    
    func bind(onChange: @escaping onChangeClosure) {
        self.onChange = onChange
        self.onChange?(self.value)
    }
}
