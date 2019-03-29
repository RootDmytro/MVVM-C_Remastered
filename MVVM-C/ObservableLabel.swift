//
//  UILabel+Binding.swift
//  MVVM-C
//
//  Created by Dmytro Yaropovetskyi on 3/29/19.
//  Copyright © 2019 Dmytro Yaropovetskyi. All rights reserved.
//

import UIKit

class BindableLabel : UILabel {

    // TODO: replace
    private var observers = [String : (String) -> Void]()
    
    deinit {
        removeObserver(self, forKeyPath: "text")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addObserver(self, forKeyPath: "text", options: .new, context: nil)
    }
    
    func subscribe(withIdent ident: String, withInitial: Bool, reporter: @escaping (String) -> Void) {
        observers[ident] = reporter
        
        if withInitial {
            reporter(text ?? "")
        }
    }
    
    func bind<OtherDataType>(to other: Observable<OtherDataType>, using lock: NSLock, inFormatter: ((OtherDataType) -> String)? = nil, outFormatter: ((String) -> OtherDataType)? = nil) {
        
        let outFormatterClosure = outFormatter ?? { return $0 as! OtherDataType }
        let inFormatterClosure = inFormatter ?? { return $0 as! String }
        
        subscribe(withIdent: String(describing: self), withInitial: true) { newValue in
            if lock.try() {
                other.dataValue = outFormatterClosure(newValue)
                lock.unlock()
            }
        }
        other.subscribe(withIdent: String(describing: self), withInitial: false) { [weak self] newValue in
            if lock.try() {
                self?.text = inFormatterClosure(newValue)
                lock.unlock()
            }
        }
    }

}
