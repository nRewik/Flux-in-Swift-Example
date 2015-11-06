//
//  TodoStore.swift
//  Flux-in-Swift-Example
//
//  Created by Nutchaphon Rewik on 06/11/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation


class TodoStore: Store{
    
    static let defaultStore = TodoStore()
    
    var todoList: [TodoItem]{
        return _todoList
    }
    
    private var _todoList: [TodoItem] = []
    
    private init(){
        dispatcherToken = Dispatcher.register(dispatcherCallback)
    }
    
    
    // MARK: - Store
    var dispatcherToken: String = ""
    var listeners: [StoreListener] = []
    
    
    /*
        dispatcherCallback will be called when Dispatcher dispatches a payload.
        In this function, Store should investigate the payload type.
        If the type matches some interested domain, it should do the action depends on the data in payload.
        After the action is done, Store should emit a change event to StoreListener.
    */
    
    func dispatcherCallback( payload: Payload ){
        
        switch payload.type{
            
        case TodoAction.CREATE_TODO:
            if let text = payload.data["text"] as? String{
                let newTodo = TodoItem(text: text)
                addTodo(newTodo)
                emitChangeEvent()
            }
            
        case TodoAction.EDIT_TODO:
            
            if let text = payload.data["text"] as? String,
                let id = payload.data["id"] as? String
            {
                editTodo(id, text: text)
                emitChangeEvent()
            }
            
        case TodoAction.DELETE_TODO:
            
            if let id = payload.data["id"] as? String{
                deleteTodo(id)
                emitChangeEvent()
            }
            
        default:
            break
            
        }
    }
    
    // MARK: Payload Handler
    func addTodo(todo: TodoItem){
        _todoList += [todo]
    }
    
    func editTodo(id: String, text: String){
        guard let editedIndex = (_todoList.indexOf{ $0.id == id }) else { return }
        _todoList[editedIndex].text = text
    }
    
    func deleteTodo(id: String){
        guard let removeIndex = (_todoList.indexOf{ $0.id == id }) else { return }
        _todoList.removeAtIndex(removeIndex)
    }
    
}