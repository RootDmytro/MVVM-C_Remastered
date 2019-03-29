//
//  SomeService.swift
//  MVVM-C
//
//  Created by Dmytro Yaropovetskyi on 3/29/19.
//  Copyright © 2019 Dmytro Yaropovetskyi. All rights reserved.
//

class SomeService<DataType> {
    let parameter: Observable<DataType>
    
    init(with initialValue: DataType) {
        parameter = Observable(with: initialValue)
    }
}
