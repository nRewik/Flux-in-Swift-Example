//
//  Dispatcher.swift
//  Flux-in-Swift-Example
//
//  Created by Nutchaphon Rewik on 06/11/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation


class Dispatcher{
    
    typealias DispatcherCallback = ( Payload -> Void )
    
    private static var _callbacks : [ String : DispatcherCallback ] = [:]
    
    static func dispatch( payload: Payload ){
        for callback in _callbacks.values{
            callback(payload)
        }
    }
    
    static func register(callback: DispatcherCallback) -> String{
        let token = NSUUID().UUIDString
        _callbacks[token] = callback
        return token
    }
    
    static func unregister(token: String){
        _callbacks[token] = nil
    }
    
}

