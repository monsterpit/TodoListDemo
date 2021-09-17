//
//  Box.swift
//  TodoList
//
//  Created by Vikas S on 17/09/21.
//

import Foundation

//Boxing Technique
final class Box<T>{
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T{
        didSet{
            listener?(value)
        }
    }
    
    init(_ value: T){
        self.value = value
    }
    
    func bind(listener: Listener?){
        self.listener = listener
        listener?(value)
    }
}
