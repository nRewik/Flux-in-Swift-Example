//
//  TodoAction.swift
//  Flux-in-Swift-Example
//
//  Created by Nutchaphon Rewik on 06/11/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation

class TodoAction{
    
    // MARK: - Action Type
    static let CREATE_TODO = "CREATE_TODO"
    static let EDIT_TODO = "EDIT_TODO"
    static let DELETE_TODO = "DELETE_TODO"
    
    // MARK: - Action Creator
    /*
        Action Creator is a helper function to dispatch an action.
    
        It creates a payload corresponding to an action, then call Dispatcher.dispatch with the payload.
    */
    
    static func create(text: String){
        let payload = Payload(type: TodoAction.CREATE_TODO, data: [ "text" : text ] )
        Dispatcher.dispatch(payload)
    }
    
    static func edit(id: String, text: String){
        let payload = Payload(type: TodoAction.EDIT_TODO, data: [ "text" : text , "id" : id ] )
        Dispatcher.dispatch(payload)
    }
    
    static func delete(id: String){
        let payload = Payload(type: TodoAction.DELETE_TODO, data: [ "id" : id ] )
        Dispatcher.dispatch(payload)
    }
    
}