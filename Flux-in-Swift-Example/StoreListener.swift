//
//  StoreListener.swift
//  Flux-in-Swift-Example
//
//  Created by Nutchaphon Rewik on 06/11/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation

protocol StoreListener: class{
    func storeDidChanged( store: Store )
}