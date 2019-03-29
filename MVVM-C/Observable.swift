//
//  Observable.swift
//  MVVM-C
//
//  Created by Dmytro Yaropovetskyi on 3/29/19.
//  Copyright © 2019 Dmytro Yaropovetskyi. All rights reserved.
//

import Foundation

// not the best approach, but it's just an example
class Observable<DataType> {
    
    var dataValue: DataType {
        didSet {
            for (_, reporter) in observers {
                reporter(dataValue)
            }
        }
    }
    
    // TODO: replace
    private var observers = [String : (DataType) -> Void]()
    
    init(with initialValue: DataType) {
        dataValue = initialValue
    }
    
    func subscribe(withIdent ident: String, withInitial: Bool, reporter: @escaping (DataType) -> Void) {
        observers[ident] = reporter
        
        if withInitial {
            reporter(dataValue)
        }
    }
    
    func bind<OtherDataType>(to other: Observable<OtherDataType>, using lock: NSLock, inFormatter: ((OtherDataType) -> DataType)? = nil, outFormatter: ((DataType) -> OtherDataType)? = nil) {
        
        let outFormatterClosure = outFormatter ?? { return $0 as! OtherDataType }
        let inFormatterClosure = inFormatter ?? { return $0 as! DataType }
        
        subscribe(withIdent: String(describing: self), withInitial: true) { newValue in
            if lock.try() {
                other.dataValue = outFormatterClosure(newValue)
                lock.unlock()
            }
        }
        other.subscribe(withIdent: String(describing: self), withInitial: false) { [weak self] newValue in
            if lock.try() {
                self?.dataValue = inFormatterClosure(newValue)
                lock.unlock()
            }
        }
    }
}
