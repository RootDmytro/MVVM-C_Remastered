//
//  MenuViewModel.swift
//  MVVM-C
//
//  Created by Dmytro Yaropovetskyi on 3/29/19.
//  Copyright © 2019 Dmytro Yaropovetskyi. All rights reserved.
//

import UIKit

class MenuViewModel {

    let container: AppContainer
    let data: [MenuViewData]
    
    init(container: AppContainer) {
        self.container = container
        data = [MenuViewData(service: container.numberService, title: "Number"),
                MenuViewData(service: container.stringService, title: "String")]
    }
}

// not the best approach, but it's just an example
class MenuViewData {
    
    let title: Observable<String>
    let valueString = Observable<String>(with: "")
    let lock = NSLock()
    
    private let service: AnyObject
    
    init(service: SomeService<Int>, title: String) {
        self.title = Observable<String>(with: title)
        self.service = service
        
        service.parameter.bind(to: valueString, using: lock, inFormatter: { newValue in
            return Int(newValue) ?? 0
        }, outFormatter: { newValue in
            return "\(newValue)"
        })
    }
    
    init(service: SomeService<String>, title: String) {
        self.title = Observable<String>(with: title)
        self.service = service
        
        service.parameter.bind(to: valueString, using: lock, inFormatter: { newValue in
            return newValue.trimmingCharacters(in: CharacterSet.whitespaces)
        }, outFormatter: nil)
    }
    
}
