//
//  TodoItem.swift
//  Flux-in-Swift-Example
//
//  Created by Nutchaphon Rewik on 06/11/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation

struct TodoItem{
    let id = NSUUID().UUIDString
    var text = "hello world!"
}