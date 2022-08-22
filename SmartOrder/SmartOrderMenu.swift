//
//  SmartOrderMenu.swift
//  SmartOrder
//
//  Created by Chang Jill on 2022/8/18.
//

import Foundation

class SmartOrderMenu {
    
    var dinerName: String
    var hasOrderCache = false
    
    var aLaCarteMenu: [String:MenuItem] = [:]
    var comboMenu: [ComboItem] = []
    
    init(dinerName: String) {
        self.dinerName = dinerName
    }
}

class MenuItem {
    
    var itemName: String
    var price: Int
    var count = 0
    
    init(itemName: String, price: Int){
        self.itemName = itemName
        self.price = price
    }
    
   
}

class ComboItem {
    
    var itemArray: [MenuItem]
    var price: Int
    var count = 0

    init(itemArray: [MenuItem], price: Int){
        self.itemArray = itemArray
        self.price = price
    }
}


