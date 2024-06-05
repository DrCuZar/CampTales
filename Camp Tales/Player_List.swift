//
//  Player_List.swift
//  Camp Tales
//
//

import Foundation

class Player: Identifiable {
    
    let id: String
    var name: String
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
}
