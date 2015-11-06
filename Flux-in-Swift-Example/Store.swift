//
//  Store.swift
//  Flux-in-Swift-Example
//
//  Created by Nutchaphon Rewik on 06/11/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation

protocol Store: class{
    var listeners : [ StoreListener ] { get set }
    var dispatcherToken: String { get set }
    func dispatcherCallback( payload: Payload )
}

// protocol extension
extension Store{
    
    func registerStoreChanged( listener: StoreListener){
        guard nil == ( listeners.indexOf{ $0 === listener } ) else { return }
        listeners += [listener]
    }
    
    func unregisterStoreChanged( listener: StoreListener){
        guard let removedIndex = (listeners.indexOf{ $0 === listener} ) else { return }
        listeners.removeAtIndex(removedIndex)
    }
    
    func emitChangeEvent(){
        for listener in listeners{
            listener.storeDidChanged(self)
        }
    }
    
}